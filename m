From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Sat, 6 Jun 2020 12:46:45 +0100
Message-ID: <20200606114645.GB2055@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell> <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4303022350831159587=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michael Walle <michael@walle.cc>
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--===============4303022350831159587==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> Am 2020-06-05 12:50, schrieb Mark Brown:

> > I have no idea what you are thinking of when you say "simple-regmap" so
> > it is difficult to comment.

> I guess, Lee is suggesting to be able to create a regmap instance via
> device tree (and populate its child nodes?). Like
>   compatible = "syscon", "simple-mfd";
> but for any regmap, not just MMIO.

I don't understand why this would be anything separate to
simple-mfd.

> But, there is more in my driver:
>  (1) there is a version check
>  (2) there is another function for which there is no suitable linux
>      subsystem I'm aware of and thus which I'd like to us sysfs
>      attributes for: This controller supports 16 non-volatile
>      configuration bits. (this is still TBD)

TBH I'd also say that the enumeration of the subdevices for this
device should be in the device rather than the DT, they don't
seem to be things that exist outside of this one device.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7bgiQACgkQJNaLcl1U
h9CJwAf9GDLvYJzqBwwJ8Wam2ddh4vI4HhG+7om7V0rPbtc+8urivLRpsn4PzyP2
VEDJVR0PhbtQTX11tUL9oNelTz+H+JHuuGMFCWP/DbbHsTKucuhkpelUnW17FukC
sr8O5n3D6en4l8bj6vsfjqysrIAtZWKk+xStpf8bQ9Zu9rczpbIGa2XK6r10w27Y
jcr5C4pQfl7DlyEwdfOw22i+q+dbBuPGPd/zk/7iRp8QzvmHjE9MCr20JO3s0cuO
4wwwbMMyNZAe2HjD1IOyVfJ42Yhd+Yf+IkgSShozuk03IuU1HEWpHTyV36pXBdvs
N4lga9r/upJOfAP2iW7qqtIdU4NzZA==
=M9Xv
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


--===============4303022350831159587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4303022350831159587==--
