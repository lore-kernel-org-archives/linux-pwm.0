From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: fix device reference leak
Date: Tue, 29 Nov 2016 16:47:00 +0100
Message-ID: <20161129154700.GA20441@ulmo.ba.sec>
References: <1477997199-29305-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33714 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbcK2PrF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2016 10:47:05 -0500
Content-Disposition: inline
In-Reply-To: <1477997199-29305-1-git-send-email-johan@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 11:46:39AM +0100, Johan Hovold wrote:
> Make sure to drop the reference to the parent device taken by
> class_find_device() after "unexporting" any children when deregistering
> a pwm chip.
>=20
> Fixes: 0733424c9ba9 ("pwm: Unexport children before chip removal")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/pwm/sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYPaLxAAoJEN0jrNd/PrOhKN8P/375waiPb5QutgdHfANpcq8P
1Y31lus3JO0lmo3XJsoQDusyad2NARSOZ6iD0pqKWjQEhN0JrD3BGZbIUg9uU/lG
3G7bCVNAP/1tNxab2gYZJAL9cBYliqs2p9oNXFemxpaslC0vkzPCozLxB9ZHf6t+
ESMZsDYvaGpADGA0HgZW36/03oQ6XWSy63G+Q2GpqlEWksNIMJAAaf77aG194lH8
+qHmqQ9lSOUNKf3Xl3F6on/v5IoM69Ue3kTCJn/E42KWtLmWwHPomHeBqfAXRlAa
1APOQkv0Of73lsAjTxA/k50gEU7FB2PcWU9xlSqA6lLCjz6+sqLTzJjeSPh3Y1xJ
4ctvIPt6YLesLb6D0A19T+iItusKEFcrcnTjT5wxT2tipcp4AkqVY6qC0wd2lDgg
g94RpS2C74Pvj0EeG2WVmO45QiyOCWJ8m6TVfmWnUdlLesbdszWo68Z9ubk/uOYq
vXrNshWo5MMP0oTnPAx8hEIRzaXhBkzqz0Kv7vhu/NWp+y5y/47470k2Zm6CtIea
Fl/JlzgtXqBmhYrO9vQFNRtSd7Lxukpm2//0NoosmTdqogZs9Kd+CTzmRY98ya9w
L7yn6BwRJskHcFYURZa9CZdA2+GcnMraDfD0Eg63D+RGTiruDRldiqNGielhRh34
od3WHOANENohHMx1zDsl
=yZ7R
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
