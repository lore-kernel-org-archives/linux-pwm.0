From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 06/10] pwm: sysfs: make use of the DEVICE_ATTR_[RW][WO]
 macro's
Date: Fri, 6 Nov 2015 15:52:58 +0100
Message-ID: <20151106145258.GC8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-7-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445895161-2317-7-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:37PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> For the npwm property the pwm sysfs interface already made use of the
> DEVICE_ATTR_RO macro. This patch expands this to the other sysfs
> properties so that the code base is concise and makes use of this
> helpful macro.
>=20
> This has the advantage of slightly reducing the code size, improving
> readability and no longer using magic values for permissions.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/sysfs.c | 72 ++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 36 insertions(+), 36 deletions(-)

Applied, thanks.

Thierry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPL7KAAoJEN0jrNd/PrOh+JIP/iD1ri4czkiNsNao+LyFWqg1
X197/e70AgDzTZ7O4wiW5KDYBLEH4Mp6MS8gZUBucE+J/w4Q2nw8rvzI420kR8EK
P5M5acZw7+tmSNmjxI43wpVof5hc6goI4BYCDY3/lWhuPIKhtzXvF3ZD3Gli34es
0z9oScZn9QPXVSbxwoHtkKs/M1tJyzEXSP/eudt83kivcotMO4PhuvlrNsvJ/fBW
nPPEKAcNuUacuCJWjpj4wYKPcXTfhohrowSZXRf0hqR+FTHf+4fGCy4hyrcx4Q1q
9uyiK8p/hvAbHavTS/baP1T4hH7xFO6qYQhKdl2kf/A2rp2wMexPB013V277/NZR
gx2zpt2U1fy7CJmkzwNLy3OQGPsGNxNZOgZ9qdFZroJxNdnCZ0dkDGgrLzGyhs9T
Z4HimiTY1aKNQOkFcixUzFnm7WHgSXNsfJpqZ+w0IrpDSJBU0ZK3TMx4iDyYSh1W
bA4ZYYkS1tzVhIZlRuLExVF8T/Cad5CKWatEBgVOv6/woq3z3/yzC8SKdVOpH+99
VtcI3pTFg/bH/Zh2NMolUmcOMBtYZKVQvRC8B4Ay12C/H7d+/5SRAFOT8uqLCluR
VdWthLdePWeAnsvccqUHPN+IkDtviFOTDYS13QzWnqAQ9b4nk2HeCHaE3ok3biFe
gWeoTFSGhuf/FaebCnyo
=4eAW
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
