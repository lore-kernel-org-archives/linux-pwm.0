From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sysfs: get return value from pwm_apply_state()
Date: Fri, 10 Jun 2016 14:25:54 +0200
Message-ID: <20160610122554.GB27142@ulmo.ba.sec>
References: <1465351103-3152-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33618 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbcFJMZ5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 08:25:57 -0400
Content-Disposition: inline
In-Reply-To: <1465351103-3152-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 10:58:23AM +0900, Yoshihiro Shimoda wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>=20
> This patch adds to check the return value from pwm_apply_state()
> used in enable_store(). The error of enable_store() doesn't work
> if the return value doesn't received.
>=20
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrHRAAoJEN0jrNd/PrOhug8P/AoA56t/pfkJRAij0BA9DyWy
2v4pO6qomgWZF2iHGYo00kVDBqoRXOrit4j9n8TfDLlftsjrGrSSx1RFAwkVLuRk
WdmfxpCbfTFS/wkrgUJQZCxNfc8pVWoNZB32sp0a4Mf9VDBDISguRLFl0d89PoMO
M6QcCIrtZcUZWXhy9lOrNKSzoNTX9uZexUdtqtTDwQFN1Qweaq7p1TV9us/TWsU1
uQmaHZbtZNBkNJtJB9k3olKVoGkhHbDGQbTuYacYhGWvEAAuQAKKok9NH8m4pcJL
00we6qFz4/NDjfh4gmptiyTypKMFxlw2W4ZeGXid5RHNiQYUgL008qBCmkSjjgMF
egOGUis608FhCjqHe9Ph7La8fzyIN9sm1yMcPvFGiNNpBC4nf0dk1KIDrnDzRxzR
RRces45F0LqyO6UOlOWjfD0j46RKAvMhl64306+//wg9qlA/Nl/9cGrB9Uq3ePG9
EQkGaAJiRttu4gAAuAw4oiKRXpKdpwebQv36BqcC1A5O8A8E034WndniRUlvEvsK
kOtaSac7b3YTY4gZwJ4/2Lw+5uSzNkncoNQZyBJpqJkqAxFROSPkObNX0RenlW1V
o3Jmf7yh9aRWv0vwvnSLKSMv2eiuoE/E37vX04o1+2y4oXzr7eMiSwbwgrkzF4S0
bN2Pefm3Y/whVfIFpF85
=o3MN
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
