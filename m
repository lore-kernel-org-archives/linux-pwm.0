From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Fri, 14 Dec 2018 14:45:18 +0100
Message-ID: <CACRpkdYYRp6Ju0zMhKGxnbnPXvFZmDJUssrLf1ad9LG4cNO2Qg@mail.gmail.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com> <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal.Vokac@ysoft.com
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, l.majewski@majess.pl, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 6, 2018 at 2:41 PM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.c=
om> wrote:

> Output of the PWM block on i.MX SoCs is always low when the block is
> disabled. This can cause issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle =3D 0% corresponds to high level on
> the output. Now, when PWM is disabled its output instantly goes low
> which corresponds to duty cycle =3D 100%.
>
> To get a truly inverted PWM output two pinctrl states of the PWM pin
> can be used. Configure the pin to GPIO function when PWM is disabled
> and switch back to PWM function whenever non-zero duty cycle is needed.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Slightly different description of the pinctrl and pwm-gpio.

This looks good to me.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
