CXX = icc
COMPFLAGS = -g -std=c++11 -O2 -fopenmp
## COMPFLAGS = -g -std=c++11 -O2 
## OPTFLAGS = -xCORE-AVX512 -qopt-zmm-usage=high
OPTFLAGS = 

REPFLAGS = -qopt-report=5 -qopt-report-filter="GSimulation.cpp,125-175"
INCLUDES =

ADVPRJ = "./reports"

CXXFLAGS = $(COMPFLAGS) $(OPTFLAGS) $(REPFLAGS)

SOURCES = GSimulation.cpp main.cpp


##########################################
OBJSC = $(SOURCES:.cpp=.o)
##########################################

EXEC=nbody.x

all: clean cpu

%.o: %.cpp
	$(info )
	$(info Compiling the object file for CPU: )
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

cpu: $(OBJSC)
	$(info )
	$(info Linking the CPU executable:)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $(EXEC) $(OBJSC)

run:
	$(info )
	$(info Run the default test case on CPU: )
	./nbody.x

asm:GSimulation.cpp
	$(info)
	$(info Generate assembly code: )
	$(CXX) $(COMPFLAGS) $(OPTFLAGS) $^ -S

clean:
	rm -f $(OBJSC) nbody.x *.optrpt *.s


#----------------------------------------------------------------
#---------- Intel Advisor Analysis ------------------------------
#----------------------------------------------------------------

survey:
	vtune -collect survey -r $(ADVPRJ) -- ./nbody.x

roofline:
	vtune -collect survey -- ./nbody.x
	vtune -collect tripcounts -flop -- ./nbody.x

map:
	vtune -collect map -mark-up-list=1 -- ./nbody.x

open-gui:
	vtune-gui $(ADVPRJ)/$(ADVPRJ).advixeproj >/dev/null 2>&1 &

clean-results:
	rm -rf $(ADVPRJ)

