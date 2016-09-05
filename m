From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Unexport children before chip removal
Date: Mon, 5 Sep 2016 16:46:41 +0200
Message-ID: <20160905144641.GR31424@ulmo.ba.sec>
References: <1470779866-74776-1-git-send-email-davidhsu@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36222 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbcIEOrN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 10:47:13 -0400
Content-Disposition: inline
In-Reply-To: <1470779866-74776-1-git-send-email-davidhsu@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Hsu <davidhsu@google.com>
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--PPxI8paQBs33t8dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 02:57:46PM -0700, David Hsu wrote:
> Exported pwm channels aren't removed before the pwmchip and are
> leaked. This results in invalid sysfs files. This fix removes
> all exported pwm channels before chip removal.
>=20
> Signed-off-by: David Hsu <davidhsu@google.com>
> ---
>  drivers/pwm/core.c  |  2 ++
>  drivers/pwm/sysfs.c | 18 ++++++++++++++++++
>  include/linux/pwm.h |  5 +++++
>  3 files changed, 25 insertions(+)

I've applied this with the following added to the commit message:

	Fixes: 76abbdde2d95 ("pwm: Add sysfs interface")

since this seems to have been wrong since forever.

Thierry

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzYVQAAoJEN0jrNd/PrOhA5UP/R7M2XL5hgcRUiaLL2W2x866
TR0jMK8I1iwgOxctZyI0R5qeaKTd5LhTrnsIKAT4gS1gbjDyAAOgq5eQUgPq+71M
ObCxX+p4tPSKv9IPvphKmXsjfxBUiNktguBqAMrxCj6qRcEXC+Of01v2vXujbTIB
OBtw2Z9PwKkqrhwkD55BukN+mVMY8JCYxPUw49Kg7CLYmShH07s9AdDNTo2rF4/2
5muANqj/IhvjBIJo+obYyEEc+CmLTgWcVwakU8Si/di9CYLUs1yCI2cHvLmdfxgQ
SYydEh4H1C7dYWof0/Q9fuhbj56nL1Xu/jxhjaCzQ47cevy5LOe6dIRNCkJJTTey
ye3Atlr3AxfBRiNd5Zc38hDJ3wU7cvNMmMI22L92X54/AXi3F1C1FrfJRMD9INV/
a1lFy+tVSIWC1lUZ6HcUI/pMBAnidZz7KE0tDfuLFPnO115XbLoIxu+/9h8HzoIk
QJXWxSZ7XT4MvaWP5d9GqUcfGuihj9brQeEFHcY8jXXAtbYGcJd3rXzPV7IETk2P
asbCH3WrLg/o8tCbh3uC0bI/4snk5Yw8+lOirtkwwrv8qXxekQkiIIGZ5EcgQ5uG
3WVE5uVRu4r0WYCdJ04JlmienpnQlQblcFwwVvinVqOkYeXtbz/LTwWYO8jIN5os
de07oUxPCgEIEyNlKtvS
=HmMz
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--
