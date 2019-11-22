From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Fri, 22 Nov 2019 14:23:30 +0100
Message-ID: <CACRpkdYMoRXT0vGT2NfQaSq6jU-0m3A4JGrk7YAhtDih3meBQA@mail.gmail.com>
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122113230.16486-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 22, 2019 at 12:32 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'm happy with this patch, but I would need Thierry's consent
to merge it so waiting for his ACK.

Yours,
Linus Walleij
