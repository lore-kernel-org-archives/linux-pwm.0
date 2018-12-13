From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v4 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Thu, 13 Dec 2018 09:56:05 +0100
Message-ID: <20181213085605.j2e76y67srg5qfbc@pengutronix.de>
References: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
 <1544616263-82642-3-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544616263-82642-3-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Dec 12, 2018 at 12:04:51PM +0000, Vokáč Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
> 
> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
> state is selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
> configured as input and the internal pull-up resistor is used to pull the
> output level high.
> 
> If all the pinctrl states and the pwm-gpios GPIO are not correctly
> specified in DT the PWM work as usual.
> 
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness = 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
> 
> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
> 
> +--------------+------------+---------------+----------- +-------------+
> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
> | 100k pull-up |            |               | enable 30% |   disable   |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |    default    |   default  |   default   |
> | out H   __________________                   __   __                 |
> | out L                     \_________________/  \_/  \_/\____________ |
> |                                           ^    ^    ^                |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
> | out H   __________________________________   __   __   _____________ |
> | out L                                     \_/  \_/  \_/              |
> |                                           ^    ^    ^                |
> +----------------------------------------------------------------------+

Just for the record: My last concern against this patch set (that I sent
for v3) and v4 of the series criss-crossed. So the problem with the
peaks that could happen is still unaddressed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
