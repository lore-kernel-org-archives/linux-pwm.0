From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation with COMPILE_TEST
Date: Fri, 29 Nov 2013 14:51:25 +0100
Message-ID: <7787436.L49ODt45in@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131129105353.GI22771@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2988912.cL2yqq4KJ2"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:40089 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3K2Nvj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Nov 2013 08:51:39 -0500
In-Reply-To: <20131129105353.GI22771@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--nextPart2988912.cL2yqq4KJ2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Friday 29 November 2013 11:53:54 Thierry Reding wrote:
> On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> > This helps increasing build testing coverage.
> > 
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: linux-pwm@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Acked-by: Simon Horman <horms@verge.net.au>
> > ---
> > 
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'm not sure if this has been answered in any of the various subthreads
> before. I've tried to read through them, but I may have missed some. It
> was mentioned that iowrite16() wasn't supported on all architectures;
> won't this possibly cause randconfig autobuilders to break?

That's possible (although it has been reported to me that the situation got 
fixed on arch/cris in v3.12), but the only way to find out is to try it. That 
would be a bug in the architecture, and it should then get fixed.

-- 
Regards,

Laurent Pinchart

--nextPart2988912.cL2yqq4KJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSmJvpAAoJEIkPb2GL7hl1b5wH/3eczIp+Y0dVN8xsHSIdJgtu
mMnceSeMKFtkNmf6IzSAjuKFGSAL7jJ0Vdikdf9LwkX6DAaWs4BzWruP4m79evrm
sYizEhdaB4BTfjAepwioawTTDU0VYWUT8jOfTERcKu/Kg9Qpbk4F4hKOwr5HApqm
pm33JHvjbRaZP/ccwZ7FriYkfd5+kGm5Fy72Lygw3BbDBemeMhF7NfV01Lyj8w9i
YyONtYZ/PQDkYzdUgg3SzTtxUt/VZ0oZbGK3cHW5NwDUaX/s2ox4WpBTjWtTvCMj
k414oQn6t2QfL1CKrNOISfNNctvBk/X5lLbsbzVTO1OLCBFo9qd+ZkXm5T5DXgc=
=f+vB
-----END PGP SIGNATURE-----

--nextPart2988912.cL2yqq4KJ2--

