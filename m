From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: sysfs: Convert to use ATTRIBUTE_GROUPS macro
Date: Wed, 4 Dec 2013 11:36:29 +0100
Message-ID: <20131204103628.GD26589@ulmo.nvidia.com>
References: <1386152993.22135.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:55189 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab3LDKh2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 05:37:28 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so6576007bkb.12
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2013 02:37:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386152993.22135.0.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 06:29:53PM +0800, Axel Lin wrote:
> Use new ATTRIBUTE_GROUPS macro to reduce the number of lines of code.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> v2: update commit log
>  drivers/pwm/sysfs.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnwWsAAoJEN0jrNd/PrOhFJsP/R0Kn+fPnM6GbEVtiHgP82AS
VDuoWgKPQZekeZpSC7IT5u64vMkt5N6z004Bpe72ve6MH69ItjL202B6e+bEdUY7
+lsm+xoCXKP0y/Gq4C87gHiLw8fKFcIok0zZPqS7gu1LIEjxGfpfVxBvMPn/4uF9
ix/Nr0j21LyEczGOFdCzD4YGudzWNCiSWnZmmvmzbh6XdQrIeXisYDV3r+uviSGj
/AHTQDcUreHtdL5fDAIW4Vyr44h60t/68VSuKzwux8CnWSjYt2zJWA6mxifdUQts
vLXSA2Ori2QFynKt3IngzHPTy9GSP14V3muaGtTlpl+MV1WDgOmf2Q6vLxaVnnSZ
3u22sCcCrwWnAOXahtrOlB8dJowS63xoKkwKreF8Fclu7evZyssF0Jd/jsrTJc2t
h8jXg8wzt9zgpLeEWscqc6IlnST4qjZzS4mFzRSoU7eQHjCQ1Z4QkBbf/czYbu0e
hjKkEk4rjKQ+EslGRz1Rx7E953UyzWgN1ss40igy7KSmKZekwMIGIkDyzoD566rz
yp6TWyUTjStMSAPH9zpiLCKLN/BbDwsgZ31d4hTBb+sb8LwDwf3LQz7oq08rEf3G
pA0pLYPZowVZYWe9SvIcPcNFEmUCRSd2D6iR5vVlpdpEOsSckT2X4BwXrDt/jbHW
TS/fjj9ILitNOoNJNVLt
=xFkr
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
