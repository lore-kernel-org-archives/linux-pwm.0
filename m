From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Thu, 23 Aug 2018 13:19:35 +0200
Message-ID: <20180823131935.1eae184f@ipc1.ka-ro>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
        <20180823123759.68b78e9f@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823123759.68b78e9f@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Lukasz Majewski <lukma@denx.de> wrote:

> Hi Michal,
> 
> > Output of the PWM block of i.MX SoCs is always zero volts when the
> > block is disabled. This can caue issues when inverted PWM polarity is
> > needed. With inverted polarity a duty cycle = 0% corresponds to solid
> > high level on the output. If the PWM is dissabled its output
> > instantly goes to solid zero which corresponds to duty cycle = 100%.
> > 
> > To have a trully inverted PWM output configure the PWM pad as a GPIO
> > with pull-up. Then switch the pad to PWM output whenever non-zero
> > duty cycle is needed.  
> 
> Just to ask - Is your display equipped with power supply enable/disable
> pin?
> 
> As fair as I remember the trick to avoid flickering the display
> was to disable the display (enable-gpio property) and set the PWM PIN
> as GPIO to high in u-boot.
> 
Unfortunately there are both types of displays. Some with an ENABLE
pin, some without.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
