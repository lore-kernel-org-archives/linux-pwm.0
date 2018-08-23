From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Thu, 23 Aug 2018 13:18:16 +0200
Message-ID: <20180823131816.741c09cc@ipc1.ka-ro>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
        <20180822081436.13d8f55b@ipc1.ka-ro>
        <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
        <20180822131758.162d5351@ipc1.ka-ro>
        <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
        <20180822161036.4d69bdc1@ipc1.ka-ro>
        <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Michal Vokáč <michal.vokac@ysoft.com> wrote:
> On 22.8.2018 16:10, Lothar Waßmann wrote:
> > My use case is attaching different displays to the same baseboard,
> > where some displays have the brightness control pin inverted with
> > respect to the others. It's easy to change the compatible string for
> > the simple-panel driver and the PWM polarity setting for the
> > pwm-backlight driver from U-Boot according to the display model, but
> > it's not so easy, to edit the pinctrl settings from pull-up to
> > pull-down or vice versa.  
> 
> OK, I got it. Though that is something different than having two clients,
> right?
>
> You do not actually need to change the pinctrl pull-up/down configuration
> in bootloader. You define the two pinctrl groups as I suggested in the
> example. Or more precisely, you add a new pinctrl group where the PWM
> output pad is configured as a GPIO with pull-up. You add this group to
> all your common device trees. This does no harm as the group is not used
> yet.
> 
> In bootloader you detect the type of the panel. Normal PWM polarity? OK,
> do nothing and boot. Inverted PWM polarity? Set the pinctrl-names property
> to "default", "pwm". Set the pinctrl-0 property to point to the GPIO group
> and set pinctrl-1 property to point to the old PWM group.
> 
> E.g. something like:
> 
> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-names default pwm
> => fdt get value gpio-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-gpio phandle
> => fdt get value pwm-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-pwm phandle
> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-0 ${gpio-phandle}
> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-1 ${pwm-phandle}  
> 
> Will this work for you?
> 
This would probably work, but it's quite ugly.
I'd still prefer to set the pin output state to the desired level
rather than relying on the chip internal pullup/pulldown facility.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
