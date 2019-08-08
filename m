Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35683 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfHHLV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 07:21:26 -0400
Date: Thu, 8 Aug 2019 13:21:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190808112122.GB24700@ulmo>
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, youling257@gmail.com, Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 12:19:53PM +0200, Hans de Goede wrote:
> Thierry,
>=20
> Ping? This fixes a somewhat serious regression in 5.3, can we please get
> this queued up for merging into 5.3 ?

I've pushed this out. Let's give it a day in linux-next and then I'll
send out a PR for v5.3-rc4.

Thierry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1MBa4ACgkQ3SOs138+
s6FKxBAAlP3tvnhfhLVbpQqyDaN+C0XgMSOEzrHXwt4unMwechd56DQ/1Nnc+6sy
+leBJTsFDLMrecIJFsyMlwuCp4P99NvfkXynpdrC/mJPYmNPVGpvx6erYntcGUpP
9RpzEvXyKxKW5AUjcXUudAunWEODeHrJNkfFmDX1SR/ejPJKd4PWxzawY9f0xKRd
PZa8veM6bdZyHlNCKOh+FspcA0PuuQqjoxN4KkHX+siqxH36D4RYCUSBH5dAXDY5
rt8vcvW0GyL9dBrHBfWJ6x1Fbx7iYpCDn3ImvyJUEnWzw8muolKXkCwHgBE0uC54
ba110twT90SV1CZ5DwiCQOV+xEk6vAXQuwvw0jzd1d43ls7s8z2rdcb9w50spc/m
omz7foMxk1RnuiUbnq6aRQ6FbG4iRIFLEtBKzNkCo2QPn7KjNYsJKpHlCJLTjRQc
XdYN5Pfw1eOo3JCAn54V5B1IgQm4ECQlrVpj3S9akqOWivsUTcJbF9XgjRbN4px7
dMtN19V/1NCIhB4fq+9ac3oNQpBz0MsuXbiWEN3ulu1TR9vi3XglvGLRecbmKfaK
15Mb7qTvyy4DDEkFl89zIT4KFbY8jNYpX/HNGOgl+F3YOseqUbQ7BQhLtJ3FFRRz
VHz2iSj+QQ2fX2cct6pm+Yo0BpLhoW6ZerFd2mmtrxFDcQryJkk=
=JqP9
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
