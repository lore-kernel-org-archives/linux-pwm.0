From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/12] device: property: delay device-driver matches
Date: Thu, 16 Jul 2015 21:23:12 +0100
Message-ID: <20150716202312.GD11162@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ec3vSN46Jxtc8xEl"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pwm@vger.kernel.org


--ec3vSN46Jxtc8xEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 11:40:56AM +0200, Tomeu Vizoso wrote:

> Delay matches of platform devices until late_initcall, when we are sure
> that all built-in drivers have been registered already. This is needed
> to prevent deferred probes because of some dependencies' drivers not
> having registered yet.

I have to say I'm still not 100% clear that special casing platform
devices makes sense here - I can see that platform devices are usually
the first devices to instantiate but there are other kinds of devices
and it's not obvious what the benefit of specifically picking out
platform devices as opposed to just deferring all devices is.

--ec3vSN46Jxtc8xEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqBKvAAoJECTWi3JdVIfQlTsH/RXV9XfaZAGK0pNr9p/kND/R
uXvreuA2aWGY2yegWXN1tE6pZoLjM18lOibs3dQes0xY7JmZ3QgWwDq46ZdT8wCD
mXlcO6E5d5QFKWa2bRcaXn02uROZmSH7X/XDk4hPVw1mh/sSxvYrj6Y0Ro0n/7Q6
RRbg1kCfVPmuBJl10kMhwC9XalK5q2g4U2xC76edvSu2kRe2TXB/J89iq9LKg+Li
LqQr20pwmwu6oIhI5YQPNa+bXNDEq5gdbq/j3hK5RRF9iXUbsuSdRDAQxTM8+5ri
/qHqGpBhW3umrDgLMBfp36F+aWy+gk1rwUFBwOB5VyG426LWzgdc7AIGPwT7i+I=
=OTlG
-----END PGP SIGNATURE-----

--ec3vSN46Jxtc8xEl--
