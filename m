Date: Fri, 15 Jan 2021 16:47:38 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: mvebu: fix pwm .get_state period calculation
Message-ID: <YAG40eoRhk3f1rlj@ulmo>
References: <cover.1610529002.git.baruch@tkos.co.il>
 <57860e4929a9d20d73f5e003a148b86a9f82310e.1610529002.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57860e4929a9d20d73f5e003a148b86a9f82310e.1610529002.git.baruch@tkos.co.il>
List-ID: <linux-pwm.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chris Packham <chris.packham@alliedtelesis.co.nz>, Sascha Hauer <s.hauer@pengutronix.de>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 13, 2021 at 11:22:41AM +0200, Baruch Siach wrote:
> The period is the sum of on and off values. That is, calculate period as
>=20
>   ($on + $off) / clkrate
>=20
> instead of
>=20
>   $off / clkrate - $on / clkrate
>=20
> that makes no sense.
>=20
> Reported-by: Russell King <linux@armlinux.org.uk>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>
