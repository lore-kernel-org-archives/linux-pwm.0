From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Thu, 12 Dec 2019 16:26:41 +0100
Message-ID: <CACRpkdZt25zK3WD9qZdJ=Aeq9YbcavJPVOX=kt8qWLdH1dHckA@mail.gmail.com>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191129191023.2209-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 29, 2019 at 8:10 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Changes in v4:

I'm fine to merge this v4 if I get Thierry's ACK on it.

Yours,
Linus Walleij
