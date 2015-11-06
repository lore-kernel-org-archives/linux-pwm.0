From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 1/1] pwm: core: Set enable state properly on failed
 call to enable
Date: Fri, 6 Nov 2015 14:46:39 +0100
Message-ID: <20151106134639.GC31835@ulmo>
References: <1445042458-30725-1-git-send-email-jonathar@broadcom.com>
 <1445042458-30725-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37923 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964903AbbKFNqm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 08:46:42 -0500
Content-Disposition: inline
In-Reply-To: <1445042458-30725-2-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 05:40:58PM -0700, Jonathan Richardson wrote:
> The pwm_enable function didn't clear the enabled bit if a call to a
> clients enable function returned an error. The result was that the state
> of the pwm core was wrong. Clearing the bit when enable returns an error
> ensures the state is properly set.
>=20
> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/core.c  | 33 ++++++++++++++++++++++++++-------
>  include/linux/pwm.h |  2 ++
>  2 files changed, 28 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPK8/AAoJEN0jrNd/PrOhU6oP/RvB6PfeyI3MFcggtU1L1/mv
hUNLhoj8Acfhaw10FB4iKPFdF0JJ7EIuj6k1xEDtkOtCQQ+SjKl1EEGHxodAz1A3
6DFhpEdS7c8gnCAjjvjC0XXGW558h8Jg+Kvn8+BlGmzt3o4e+kqJ93u0FwJ1eOpr
EY4mYkn64YoKIGBb01I0JpgEyiommGAZxBICE8LdpU6NtPxTCvALjvDM7wc6Rx1/
+FMguL60Y2znd7JYMeaghv5NWn/e7+2D/n3yV8aHDqYaxKFrDmWZnFV/X6jE8K3n
Iasi1wr+RPdQ2zlwU9E0kNbZIzg+KavguoKnl2mclSQvBUN6yL69/Xc/XZDuP0Hx
/0zanr7xv7Q9YbXRoVClAjDPTy6KtpG6Zw+q3nzlh6SNF4ijWPZQ/rbBz75+9zfD
qtD3/yBpVPP0vxG27QwY7xcMl7U54EajpjZLc7bbLCoGh8zvW7CnueNLtFAQl3IM
fj5KFqlwGk89DQ5kh0qRPmaRjg5DeiVUgGgFJ4n+DigWfQYpG+c/4MhPYpHFRPAE
cAucs4jHI8ZHNdYVgGzudVloA3RiJG2j29rSsTa7n5xgnXzZ57cqTWqaZC9sG+Q6
AlRIMTgNi/I42GmUI3RG0wPupeGrnVgtmz/uFHtSDn0ww6FRoPRDYR17EyfnI03I
lBtkBB0SBmzEDOt7B9zh
=I5BO
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
