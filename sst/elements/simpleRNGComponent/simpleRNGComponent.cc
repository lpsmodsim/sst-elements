
#include "sst_config.h"
#include "sst/core/serialization/element.h"
#include <assert.h>

#include "sst/core/element.h"

#include "simpleRNGComponent.h"

using namespace SST;
using namespace SST::SimpleRNGComponent;

simpleRNGComponent::simpleRNGComponent(ComponentId_t id, Params_t& params) :
  Component(id) {

  unsigned int m_z = 0;
  unsigned int  m_w = 0;

  m_w = params.find_integer("seed_w");
  m_z = params.find_integer("seed_z");
  rng_count = params.find_integer("count", 1000);

  if(m_w == 0 || m_z == 0) {
	rng = new SSTRandom();
  } else {
	rng = new SSTRandom(m_z, m_w);
  }

  rng_noseed = new SSTRandom();

  // tell the simulator not to end without us
  registerExit();

  //set our clock
  registerClock( "1GHz", 
		 new Clock::Handler<simpleRNGComponent>(this, 
			&simpleRNGComponent::tick ) );
}

simpleRNGComponent::simpleRNGComponent() :
    Component(-1)
{
    // for serialization only
}

bool simpleRNGComponent::tick( Cycle_t ) {
	rng_count--;

	std::cout << "Next uniform random: " <<
		rng->nextUniform() << " / No seed=" <<
		rng_noseed->nextUniform() << std::endl;

  	// return false so we keep going
  	if(rng_count == 0) {
		unregisterExit();
  		return true;
  	} else {
  		return false;
  	}
}

// Element Libarary / Serialization stuff
    
BOOST_CLASS_EXPORT(simpleRNGComponent)

static Component*
create_simpleRNGComponent(SST::ComponentId_t id, 
                  SST::Component::Params_t& params)
{
    return new simpleRNGComponent( id, params );
}

static const ElementInfoParam component_params[] = {
    { "seed_w", "" },
    { "seed_z", "" },
    { "count", "" },
    { NULL, NULL}
};

static const ElementInfoComponent components[] = {
    { "simpleRNGComponent",
      "Random number generation component",
      NULL,
      create_simpleRNGComponent,
      component_params
    },
    { NULL, NULL, NULL, NULL }
};

extern "C" {
    ElementLibraryInfo simpleRNGComponent_eli = {
        "simpleRNGComponent",
        "Random number generation component",
        components,
    };
}
