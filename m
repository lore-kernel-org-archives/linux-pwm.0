From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Date: Fri, 14 Dec 2018 15:56:39 +0100
Message-ID: <CACRpkdYo0RrQTnjQhxG=CRa1AWoRrVjL9naYC_ZCz2_dzAz-Jg@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de> <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de> <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk, prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk <linux-clk>
List-Id: linux-pwm@vger.kernel.org

On Fri, Dec 14, 2018 at 3:26 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:

> > So if the PWM case is something similar, then by all means add
> > num-pwms.
>
> .. or "npwms" to use the same nomenclature as the gpio binding?

Either works for me, I don't have a very high need of consistency
but there are others that have so your suggestion seems wise.

Yours,
Linus Walleij
