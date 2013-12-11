From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation with COMPILE_TEST
Date: Wed, 11 Dec 2013 13:49:53 +0100
Message-ID: <2487119.M3l3CLesSz@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131129105353.GI22771@ulmo.nvidia.com> <7787436.L49ODt45in@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1722428.a4LKQWphW0"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42979 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3LKMtq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2013 07:49:46 -0500
In-Reply-To: <7787436.L49ODt45in@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--nextPart1722428.a4LKQWphW0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Friday 29 November 2013 14:51:25 Laurent Pinchart wrote:
> On Friday 29 November 2013 11:53:54 Thierry Reding wrote:
> > On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> > > This helps increasing build testing coverage.
> > > 
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Acked-by: Simon Horman <horms@verge.net.au>
> > > ---
> > > 
> > >  drivers/pwm/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > I'm not sure if this has been answered in any of the various subthreads
> > before. I've tried to read through them, but I may have missed some. It
> > was mentioned that iowrite16() wasn't supported on all architectures;
> > won't this possibly cause randconfig autobuilders to break?
> 
> That's possible (although it has been reported to me that the situation got
> fixed on arch/cris in v3.12), but the only way to find out is to try it.
> That would be a bug in the architecture, and it should then get fixed.

Would you consider picking this patch up for v3.14 ?

-- 
Regards,

Laurent Pinchart

--nextPart1722428.a4LKQWphW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqF92AAoJEIkPb2GL7hl1UDoH/Ah3klx7HNe3xJLfsuK/GDry
0F40ERbGf3b5NHX3csKvKzlsHTY0cVdMl4GDEKvEe5pfs4fFDOSaRCLI8Xh4Vg31
JFsDkcMow7at/06jFhtKUI6KAqzCetAVQSpLWY/ubV0pEIZWvM/7IjCAMje0bhiw
VBR/MHwVVMAxeizCpTzCAVWVRsCu4n+uavN6VwCCK8lx+avw5BJXxBQ6BUbz5XI9
CEFvzL9eCJSH4qjb449vdCkDPQMjJ5bgTxWKFbOlPFxCGnpDvo8mUjP4u/bXoGjA
2f3IJjauG8/95YjDJ64+QXv6dqNdFvuXv3YJFwb3JHykN7+R6ELqoePgf23j9Xs=
=GMv8
-----END PGP SIGNATURE-----

--nextPart1722428.a4LKQWphW0--

