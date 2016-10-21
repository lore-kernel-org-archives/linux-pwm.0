From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: meson: Remove unneeded platform MODULE_ALIAS
Date: Fri, 21 Oct 2016 09:13:01 +0200
Message-ID: <20161021071301.GC2670@ulmo.ba.sec>
References: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32860 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbcJUHNF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 03:13:05 -0400
Content-Disposition: inline
In-Reply-To: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 04:49:59PM -0300, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
>=20
> So there's no need to have a MODULE_ALIAS("platform:meson-pwm") since
> the reported uevent MODALIAS to user-space will always be the OF one.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>=20
>  drivers/pwm/pwm-meson.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCb/9AAoJEN0jrNd/PrOhFqUQAIgyWCKOgNRGC0O1Y5nsBeEl
ZhEX3798xQJLXnC5gNaAnyC35cRib17/gAUXYuWT9SmWAk4tMMJ5mzgp9Ptiv3DZ
MtBcpRysGu781bFFNxLRiCDnlPDiqES9TUqQA6kiyeEZ05HQeHu9JIkJbaz3nWnC
/1JN/GtbfimReZ+9QsE5KAGehmRV9fw72qYtVrZ/4mt8LmJlwd3rhhZuQq/Sn84y
YRgO+sqNOG1v6CAz2peIlqws/6VAqO8M8xPjRk0EAwlY9TNGeivDfFaFzk8aVGWA
dZP8v3510eCsOFbB2wsHTKbBtbxqqOm4eq37w3cjbe+tsz+fwXlzhSyPhkVfhyYS
Lw+h58MY+QsytXeV+c7aukXg7QIyscS/gPbLoem5QZEPM96TY88GJHqhygBY2TxR
OWO+n41EKHlwW9e/WleUwQxvSAUQaxg41S7Uv5EKmQ3+KWU1oUK1REuSjdNlT5nV
NYBN5R003VPNkbEFIFkPr0WGTSft5vNAMRYpzDrM4lFWhgWnwxnBeEyN6ZpESNpP
DYuSowp0nTebRxUh6c6OWX319ZCq5yogC73nDFRO5GPgMbbJPT2+G+Ahhr/hCawH
dckFNrCakZ5lEXfYepjPE1et8NQ5IDYKCtjNO+eSXW3TuX5QlOBYSAIf1n5bUBt2
hIttB43Cc1fkvhn6RuUI
=Dk9Q
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
