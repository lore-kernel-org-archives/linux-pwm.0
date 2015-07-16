From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/12] regulator: register dependency parser for
 firmware nodes
Date: Thu, 16 Jul 2015 22:38:23 +0100
Message-ID: <20150716213823.GF1602@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-10-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54771 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbGPVic (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jul 2015 17:38:32 -0400
Content-Disposition: inline
In-Reply-To: <1435743667-11987-10-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 11:41:04AM +0200, Tomeu Vizoso wrote:
> So others can find out what depends on regulators, as specified
> in bindings/regulator/regulator.txt.

Reviewed-by: Mark Brown <broonie@kernel.org>

=66rom a regulator point of view.

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqCROAAoJECTWi3JdVIfQ+AwH/04Bu5SZtx2282qv6iBescZI
U/Yb79sUSK+1iDsmHnzCBj1PzWhv+HA2OO7bDXFxr16NrQWy2f8Dth/O+UszLXR6
b8ij8CKmEF+H4AVYO0rRl2w5bdZl6G9L5Q3gmUI/xlB8GDzZ4h4qeftkXHUhZBi0
8EROjAqfZbyfHycme3lPO0+lJ+iNCihGEHYGEqEuNruCjNSCmNrZnCDL3LclEjId
ppJtILExl9QYqIiprBxWvtT2DYUXXDsNA9ADOq80kpuSsShPXgNwmhDjYG4sofLs
nDRRUWDhL4eOOsS68mLjHLN0MfParQccjJOu1KRp2+7I1Jgg4tAC+ddRCJq35BA=
=8p4T
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
