From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
Date: Tue, 28 Apr 2020 16:25:43 +0100
Message-ID: <20200428152543.GI5677@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
 <20200428124548.GS185537@smile.fi.intel.com>
 <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
 <20200428142938.GX185537@smile.fi.intel.com>
 <6ccad285-7b5f-3037-d4d5-ff4d9571b612@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ccad285-7b5f-3037-d4d5-ff4d9571b612-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas
List-Id: linux-pwm@vger.kernel.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 03:49:49PM +0100, Robin Murphy wrote:

> For better or worse, the platform bus is the dumping ground for random crap,
> so we just have to deal with all the abstraction breakage that leaks out of
> that.

The reason we're using the platform bus for this is that historically
people were creating buses which were essentially carbon copies of the
platform bus with the name changed and it was felt that rather than
duplicate code it was better to just use platform devices with no MMIO
ranges defined.  If there's some assumptions about DMA for platform
devices floating about somewhere it might be reasonable to revisit this
and create a non-DMA variant of platform devices since there is a
meaningful difference.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oSvYACgkQJNaLcl1U
h9Bs4Qf/RCa5JW+qq8H0nchlRU4JeR7TBiAfPi1/fksL+W8k+qMkV0/KwPSMqloA
CaWErSXTzc1Mk3WKIT7UxNlcK1QsuUfNZnyA3JhFXAg39xjWpt2vSM7A/zY5mnOm
ZkujuFzw0NzNuBoxG+8OaBH1Ltitu/KpgCPJgrmwT09V5WuZ5uf8b3mjnEo0reaN
DYcUgV/u3XkUeSbMd1iljqd8bt+jHFHoFlVOVtcw+xh20cKvQ6kOzIPYlDbuz9rM
tGPZwlyojrQeFd8YYTh1hqSzqeB6E19JgdPEi9P34gi7rIctOcI6b9PwFO9er5fW
ov2hgkFJC60dI+z5f9j70bLBQfMw/w==
=hzNB
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
