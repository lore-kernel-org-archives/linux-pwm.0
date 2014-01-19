From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: PWM...
Date: Sun, 19 Jan 2014 16:49:57 +0000
Message-ID: <20140119164956.GR15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41804 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752371AbaASQuF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jan 2014 11:50:05 -0500
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, arm@kernel.org

So, having looked at what else I can add support for on the cubox-i, I
decided it would be nice and simple to add support for the front panel
LED.  What could possibly go wrong with this.

Well, the hardware is wired such that the LED is connected between the
PWM output and +3.3v.  So, a constant low turns the LED on full, whereas
a constant high turns the LED off.

So, the polarity of the LED is inverted - but this _can't_ be specified
in the totally and utterly fucked misdesigned crap that DT is:

        pwmleds {
                compatible = "pwm-leds";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
                  
                front {
                        label = "imx6:red:front";
                        pwms = <&pwm1 0 50000>;
                        max-brightness = <248>;
                };
        };

                        pwm1: pwm@02080000 {
                                #pwm-cells = <2>;
                                compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
                                reg = <0x02080000 0x4000>;
                                interrupts = <0 83 0x04>;
                                clocks = <&clks 62>, <&clks 145>;
                                clock-names = "ipg", "per";
                        };

Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
be specified in the pwms declaration in pwmleds.  So that doesn't work.
There's no property to tell pwmleds that it should use inverted sense
either.

Moreover, there's no way to specify a default brightness for the LED
in the absence of any trigger, so this results in the LED being fully
on.

So, something which _should_ be nice and simple is turned into a major
fuckup because of the total and utter crappiness that DT is and the
total misdesign that this shite is.

Frankly, board support via C files was FAR BETTER than this never
ending pile of shite that I'm finding with DT.  Far from making board
support easier, DT has turned it into a total disaster.  I say bring
back board .c files... DT isn't worth bothering with.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
