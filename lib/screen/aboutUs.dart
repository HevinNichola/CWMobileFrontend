import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBFAF3),
          title: const Text('About us',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF016A70))),
          centerTitle: true,
          leading: const BackButton(
            color: Color(0xFF016A70),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage(
                    'assets/images/pexels-frans-van-heerden-edited-1912176.jpg'),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Welcome to Eco Enforce, your dedicated online platform for '
                      'environmental vigilance and advocacy. We believe in the potential of '
                      'collective action to safeguard our unique wildlife and forests at Eco Enforce. '
                      'Our platform acts as a key link between concerned citizens and the organizations '
                      'in charge of wildlife and forest conservation.\nEco Enforce empowers people to be '
                      'the voice for those who cannot speak for themselves in a world where environmental '
                      'crimes pose an escalating threat to the delicate balance of our ecosystems. Whether '
                      'you have witnessed illegal logging, poaching, or any other behaviour endangering the '
                      'health of our natural environments, Eco Enforce offers a streamlined and user-friendly '
                      'interface for reporting and addressing your concerns.\nOur objective is simple but '
                      'profound to make it easier to report animal and forest crimes and to ensure that these '
                      'complaints reach the right authorities as soon as possible. Eco Enforce leverages the '
                      'power of technology to harness the potential of a linked global society, forming a network '
                      'of watchful individuals dedicated to preserving the biodiversity that sustains life on Earth.'
                      '\nHow does it work? Users may quickly lodge complaints using our user-friendly web system, '
                      'providing critical information regarding the witnessed instances. These reports are then '
                      'easily submitted to the appropriate wildlife and forests conservation institutes. Eco Enforce '
                      'transforms individual acts into a collective force for environmental protection by facilitating '
                      "open contact between concerned citizens and devoted conservation organizations.\nJoin us on this "
                      "life-changing adventure towards a more sustainable and harmonious cohabitation with nature. "
                      "Contribute to the ongoing efforts to conserve our planet's biodiversity by using Eco Enforce to "
                      "report and combat environmental crimes and Nuture Nature! ",
                  style: TextStyle(color: Color(0xFF016A70), height: 2.5),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                color: const Color(0xFFF4FAF6),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(
                            image: AssetImage(
                                'assets/images/pexels-rachel-claire-4577129.jpg')),
                        Text(
                          'Wildlife Conservation',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      'Wildlife conservation institutes are critical to protecting biodiversity '
                          'and preventing wildlife crime. These organizations work to protect endangered '
                          'animals and their habitats through anti-poaching campaigns, partnerships with '
                          'law enforcement, public awareness campaigns, and research. Their initiatives '
                          'against wild life crime, in particular, include strong steps to curb illicit '
                          'activities such as poaching and trafficking, to protect vulnerable species '
                          'and maintain the biological balance of nature habitats.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF016A70),
                          height: 2.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                color: const Color(0xFFF1FFF6),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(
                            image: AssetImage(
                                'assets/images/pexels-jahoo-clouseau-1260324.jpg')),
                        Text(
                          'Forest Conservation',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      'Forest conservation institutions work to maintain and manage forest ecosystems in a '
                          'sustainable manner. Their primary duty is to protect the essential homes of numerous '
                          'plant and animal species, to sustain biodiversity, and to protect the ecological services'
                          ' that forests provide. To combat deforestation, illegal logging, and other threats to '
                          'forests, these institutes use tactics such as replanting, habitat restoration, and '
                          'community engagement.',
                      style: TextStyle(
                          height: 2.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF016A70)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
