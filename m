From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/7] pwm: rockchip: Add APB and function both clocks
 support
Date: Fri, 18 Aug 2017 17:31:35 +0200
Message-ID: <20170818153135.GB18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-2-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502206715-24174-2-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:38:29PM +0800, David Wu wrote:
> New PWM module provides two individual clocks for APB clock
> and function clock.
>=20
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> changes in v3:
>  - clk_get with NULL argument again if it was error, when clk_get with "p=
wm" argument.
>  - To get clk count, use of_count_phandle_with_args instead of of_propert=
y_count_strings.
>=20
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  8 ++-
>  drivers/pwm/pwm-rockchip.c                         | 58 ++++++++++++++++=
++----
>  2 files changed, 56 insertions(+), 10 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXCFcACgkQ3SOs138+
s6EXURAApMbJYPOsD8nohmlo+4mCpFDpw6ON+7GP7LnPUZs/fVYxlWP239kfZ+1A
LiGVjYaySfA+Z+Njq15PZgPQQp/6SBBAYREJJVhTr0sUh7AIJZHB65IEM3IFFrBS
B8NHOl9YlqSUCigL9FcaCVo3QjcnvnKygAmgJWjjb2n9lI7DwtaD2AFTMhB7A3WA
qXc1G0Yam2tIUeHtfzq1J/8gitmMtZbLXNTEkVzA8VdL7cEVNMbcNOlrqB6OLMDK
cJh7Id3sYPIjZEM63gYsVc797ZcF01kDz0FONifW7KA9LjXwwg2V+sUxlknNiSLc
dNMKdSHfbSCp5uVv7VHbpFa+b7nhlxAnStKMmj0M/MdswEEpaRKgWmidpMkyRT5P
bRAx3ZUu54X0kkN2dEVuLLwoPJDJtFteMHid3g9o6INeRv4T9eseDb1YHO8Ad6tJ
PVEsE7II5h2XdvUsXhL1fIe2v7N8pZvWB753gREzxgFU+7qoiyEHR4Kw4dgqpBkX
Blw/xY0KxyoClugSt9MnBoR+plK9QwymfOnO9n7wnp3LWYfG3DA/VFhxve3ayqZE
6B4cAMjs0MSZe65NJn4nq4WTToMKVvRB92H91GttZMebXF1vQhl3FOzxIhDHtik0
6BdjwIFnHl7yPeE2gyITe5aHivEOL6ReEVoDwZtnDzYdbV6hZCg=
=jUMz
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
