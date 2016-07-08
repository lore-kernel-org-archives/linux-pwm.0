From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/3] Documentation: dt: Add Broadcom iproc pwm
 controller binding
Date: Fri, 8 Jul 2016 16:35:48 +0200
Message-ID: <20160708143548.GA1151@ulmo.ba.sec>
References: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
 <1467698426-27600-2-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32897 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbcGHOf4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Jul 2016 10:35:56 -0400
Content-Disposition: inline
In-Reply-To: <1467698426-27600-2-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 02:00:24AM -0400, Yendapally Reddy Dhananjaya Reddy=
 wrote:
> Add a binding for Broadcom iproc pwm controller
>=20
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadc=
om.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++=
++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.=
txt

Applied, thanks.

Thierry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXf7pEAAoJEN0jrNd/PrOh7NsP/2mtAvxW7pqglXWVKrnhsNok
Ci4IPFwx4s6FE/Us9DmFKt0NiLX9n4Jh6q8G54tMCfN1DUJ44DM3919Ink/+26b/
/mnKkcDRkUgsrAZiKEgxAVzLcUXaV8CdcFS3OkQeAt6n4LLPgceF6RTuFo8KlFwO
cfpFrGDUHeekDSE9ytiR0Yu5xqAvpUZ4zRXcllqvosGv0B2Lp67rIXbr/RpHGMeh
xnR90DeZhiUPwwBFJo2T66zHLzXG0/D893cOpS/DYr6sQlbULAfLOtKltAtMbbrv
wCMa36rl8nvduvAS18QKm1EB3/qX9QefA/XZCom0ILChjZLoVb7Z5bhVsZ7AkEZ4
4uq91VQXtL835mbfJ9F2GlUYeMzpF/dFJ/3Ui0lrQJ+Dx0Xc5hMSCxN9X9eqXWmN
5Ke1YcSFzW3QMKEAoMFaeET1krkq1QIbA4QW0JzK6Q4wJKK/fJMXzWXor1//Lc7Y
tW3O7C+E7QGi0R5SEv23ONNAG1xQawrtFOAQrt0uCmotC6IkVWcSQvEQwVZrHANz
IY0uTPO6XvQbzIFJdoGPw2ztz+wpPeBBSSvrSPtvmviEf4fUYEu2UWOpbryR3OwX
SWHUZOJAOgKdxfIlzHlv+6/0lGWQlbBaOli//lzv44wfZo22PeWIhWWeaLz2I4TL
pgIhDgb5wpdqf9IQMWLw
=fhCs
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
