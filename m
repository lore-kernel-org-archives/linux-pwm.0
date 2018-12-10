From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output  between PWM and GPIO
Date: Mon, 10 Dec 2018 17:16:25 -0600
Message-ID: <20181210231625.GA30721@bogus>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 6 Dec 2018 13:41:30 +0000, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= wrote:
> Output of the PWM block on i.MX SoCs is always low when the block is
> disabled. This can cause issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle = 0% corresponds to high level on
> the output. Now, when PWM is disabled its output instantly goes low
> which corresponds to duty cycle = 100%.
> 
> To get a truly inverted PWM output two pinctrl states of the PWM pin
> can be used. Configure the pin to GPIO function when PWM is disabled
> and switch back to PWM function whenever non-zero duty cycle is needed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Slightly different description of the pinctrl and pwm-gpio.
> 
> Changes in v2:
>  - Do not use the "default" pinctrl state for GPIO.
>  - Use two new "pwm" and "gpio" pinctrl states.
>  - Add a new pwm-gpios signal.
> 
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 49 +++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
