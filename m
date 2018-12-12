From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] pwm: imx: Use bitops and bitfield macros to define
 register values
Date: Wed, 12 Dec 2018 11:53:04 +0100
Message-ID: <20181212105304.GC17654@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:47PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Use existing macros to define register fields instead of manually shifting
> the bit masks. Also define some more register bits.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 78 ++++++++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 58 insertions(+), 20 deletions(-)

Applied, thanks.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6JAACgkQ3SOs138+
s6FWHg//XmrkBX1MOHOJxSKNoeDjxd7tnUqJ7BBL474nB+urg+LI8a1V8mdD/JQJ
/gQsfU5Fzj4SN8aPCCCagZ3VfTdpBNlU1zdyn/VLZSxsDcS5lBbjD3xj+VMrNwGF
J2hsSYnPVRtkUKhXjTAduFjkvj3z8wTr6JdXH3TFOGlB4xuNkQ/yYsi+9PYNdbSg
0Dlo44y9XsNOoWSk9he9/X3hI7zoy94RYsREGaQ7JUKRV0RVLwI/EmoDycuoX3Ao
QTs65BxCbF80OsRmRtUBnFQm9Hm+vXkYQOq29bwC10j96lvGQrB/96nlyu9QuBoo
SZ0BJXaZ2gCmMCVHDiWo9YLT9iF2hSJtgxuRktH2xgm3qLOEJ0wPhIPmz3h8keIu
FXm6g3KhO8cxI13tVYLLao4P1wmgWsAvoBdSr3aItSJYEajThxsrajuLUe7FAC+W
c2mjOPvi5s3fUWVJX889kFFcGV8D9N/asV71R8cyJkqNO1P3BDClZIn1Y5JUJ9/m
j31X9KwHB21aoe7Vh8j5Ilq9xyYvYzZTCfrsFw57O3Hd9qBpIl1OV2afiEEGHf0l
82mcGyxN2KvI3sonc2yp1f4GEofryEHr9XEfFLroV6VeXs0/7RFUI9kRWXFITuQU
EdjOAATNiNR3Z++cF2nt0++TFD4TvS3s5li5moBxitwLe21ojpg=
=X4Yq
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
