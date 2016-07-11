From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
Date: Mon, 11 Jul 2016 12:31:06 +0200
Message-ID: <20160711103106.GA5503@ulmo.ba.sec>
References: <CAL2FKYkH86zhPOrEZQ8Q=WeKUV=2KFfxfA-JTrxiqMnCceQ87g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34272 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbcGKKbK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 06:31:10 -0400
Content-Disposition: inline
In-Reply-To: <CAL2FKYkH86zhPOrEZQ8Q=WeKUV=2KFfxfA-JTrxiqMnCceQ87g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2016 at 12:22:38PM +0530, Yendapally Reddy Dhananjaya Reddy=
 wrote:
> Hi Thierry,
>=20
> On Fri, Jul 8, 2016 at 8:46 PM, Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Tue, Jul 05, 2016 at 02:00:25AM -0400, Yendapally Reddy Dhananjaya R=
eddy wrote:
> >> Add support for the PWM controller present in Broadcom's iProc
> >> family of SoCs.It has been tested on the  Northstar+ bcm958625HR board.
> >>
> >> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@bro=
adcom.com>
> >> ---
> >>  drivers/pwm/Kconfig         |  10 ++
> >>  drivers/pwm/Makefile        |   1 +
> >>  drivers/pwm/pwm-bcm-iproc.c | 268 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 279 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
> >
> > I've applied this, but I had to make a couple of changes for coding
> > style and to squash compiler warnings. Please check the PWM tree's
> > for-next branch to see if it still works for you.
> >
>=20
>   Thanks. It is working fine for me. A small change is required here,
> NSEC_PER_SEC
> instead of USEC_PER_SEC in two places.

Ah yes, I had mixed those up when converting from literal to symbolic.
Should be fixed now.

Thanks,
Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg3VoAAoJEN0jrNd/PrOhTHIP/0U8lMA/U1smGX3nldD9inSR
qFFZrqHTWQ1qMWSnjKFI8DtQsrdA7SL2DUliwxmpTJRdFFFxAPnsJ4qSZBmfbCVy
Y9Paxru5Q79GqA/7GSmy8PieNZrNzpU7hg1pa2DtvaTbEnzvJAVuZCHR9WN/8jNO
rvoRT6894SSvH82X3s+5dfisLcv6K6NJoP/3N8vz4MVSgSdwT8CoYGW0gblCn8oW
vYr1cF3sHqJe9qKVm5sp4nwwPqBhUkIOyJfQKVU2hAy/5kE6TSBs/HnYQcRMTou4
8pQfwSWcnQ5PcttVpUy1KNqtSZzjgyp3/UEFqJGwlLqThhfdNkWQ15ipg+d1KRAf
Q6hzBxPiC96MXr8MYDbqMdpx51Hx1RncE+BIPZdQvaHpMQrHyVJHHvU8Oud7oe2/
GXUjyfz4Lelcr0/RWSuCjtxOrQo0MrSMEuso7H1UNNHi+wb9A4rx+EWlp8Rlvjj9
kzbtHmD8WkJEdsB+9eYbGEx43nf7/f/yWLl3JInhKQevK2gcyXC2b8Yu/PE1dehU
sWNAEqIziJN6fLaOctV0KOQPAvyXg6/Y5TVgt2Km4YJSUUSmQv1lIwA4L1Tq4iva
doS1aRYkWIKw3pVy7X+wQhZjwr7dNOZ01Pi2Ff+2P7afs4KqgdDKkizb+p8Nh7HL
j6TX3Kse7kZpjIuinnle
=ZCNP
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
