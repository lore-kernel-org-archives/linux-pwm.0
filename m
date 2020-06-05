From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Fri, 5 Jun 2020 11:50:26 +0100
Message-ID: <20200605105026.GC5413@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8351393405076470264=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200605065709.GD3714@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--===============8351393405076470264==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 07:57:09AM +0100, Lee Jones wrote:
> On Thu, 04 Jun 2020, Michael Walle wrote:

> > +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
> > +	if (IS_ERR(sl28cpld->regmap))
> > +		return PTR_ERR(sl28cpld->regmap);

> This is now a shared memory allocator and not an MFD at all.

> I'm clamping down on these type of drivers!

> Please find a better way to accomplish this.

What is the concern with this?  Looking at the patch I'm guessing the
concern would be that the driver isn't instantiating any MFD children
and instead requiring them to be put in the DT?

> Potentially using "simple-mfd" and "simple-regmap".

> The former already exists and does what you want.  The latter doesn't
> yet exist, but could solve your and lots of other contributor's
> issues.

I have no idea what you are thinking of when you say "simple-regmap" so
it is difficult to comment.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aI3EACgkQJNaLcl1U
h9A7hQf8CDFQ5iLpXTLY4zeynMxyWKwNzkV4jtp9HDi0METL6K488ki/EvosVeJx
URGVB1pt6HfuZ+wo9eI4viS324oVbqB+OLEP2C2JT9IueDFeFAVv/ZID0FjrKlB8
3L1IaFXplUYVhcSJGxL+9p6BB2RpY2jKupLmYwudJ2RKDIT/sf011ENofTZR2i/7
mHJQsYGSN/zKTcrZm9cmx10BOmpL5aSq0hwcOM1qYqPn/tlSs09ErRh1+Tisxg+U
3ZTBCjG5cDlPj0KIBfoZkJapLQ3YklicCzY2LTKFvP1bxloxYa4iyyy0O5oHdBaK
vL9TOwYXvPCnUOSIH1toNvcVphaLDg==
=gwiS
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--


--===============8351393405076470264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8351393405076470264==--
