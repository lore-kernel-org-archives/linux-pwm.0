From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 07/14] pwm: meson: add the meson_pwm_channel data to
 struct meson_pwm
Date: Mon, 27 May 2019 19:52:49 +0200
Message-ID: <CAFBinCAYaLd60ABFxEB28p4J7FO1PRaTZ+N6Ak1AnizAKGaxnw@mail.gmail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com> <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sat, May 25, 2019 at 8:11 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> @@ -509,18 +509,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
>         meson->chip.dev = &pdev->dev;
>         meson->chip.ops = &meson_pwm_ops;
>         meson->chip.base = -1;
> -       meson->chip.npwm = 2;
> +       meson->chip.npwm = MESON_NUM_PWM;
I messed this up during rebase, the macro name is actually MESON_NUM_PWMS
I'll re-send a fix so these patches can be bisected cleanly (patch 8
fixes this typo accidentally)
