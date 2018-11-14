From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Wed, 14 Nov 2018 13:47:52 +0100
Message-ID: <20181114124752.GI2620@ulmo>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> The flag 'has_clks' and related checks are superfluous as the CCF
> subsystem does this for you.

Both of these mechanisms aren't equivalent. While CCF can deal with
optional clocks, what the has_clks flag actually means is that the
device doesn't need a clock (or doesn't have a clock input) on the
devices where it is cleared.

So I'd actually be in favor of keeping the has_clks property because it
serves as an additional sanity check. For example if you run this driver
on an SoC that "has clocks" but if you don't list them in DT, then after
this patch the driver will happily continue without clocks, even though
it may break completely without those clocks. I've seen SoCs respond to
disabled clocks for a hardware block in different ways, in many cases an
access to any of the registers will completely hang the CPU. In other
cases it may just crash in some other way or give you some sort of
machine exception. None of those are good, and make the tiny bit of
additional code required to support the has_clks flag very attractive.

But that's just my opinion. If you prefer to throw away that safety
barrier, be my guest. But if you do, please move this functionality into
the clock framework first and then make the driver use it.

Thierry

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsGXUACgkQ3SOs138+
s6EhKhAAnU52kPmOfIbVhaDxXLLAR5p0eNkpLB7VYzDDiizJGgdGfnpjgjwqPHb0
6pJf12Bo+bibjOzR/kHwv6du6ylwESC73/ZyZnFlrvGJkF2CVXgJny5vfbBxPb9X
VsRkrRjCNK4Gi4jSOieGGH3k6BpUc/xnWzlF4wkSMTl7ualJ09gct2YgrnQSgvD5
Ku1CsxGsHACXWi78uPUEjavXSkeHFHwevpRzkekeAQCzNZe12kSHbPmnHUI6lXQo
XcXvKvD6pPwPHXnMV40pKi8kldWhT6CBX/1MgukimbkxDMtUbhCLhOT1WIxn4DW8
lM1MndqkdF/CzHpop/eMQS0OTOaFI5/6NlROEjz8dOG0/RKrkgH0CxnjgeCIaDqI
jmNf0/iEVSyqsA7RbNiz4AneOfNLMlkhTTdRDU+XZukWiOKqCgStQHqfUsbeRcyV
L/ERoC/y33co9MAVYs+NVawNLu+a1344Z58d3BIR7GNO6P+DtV6W9Z5eC03rW+MP
swVsPUkMZZblcM2oE3nFEa3OoTO82aIIfrjqC13mx5iHTa6/USWRlBIwXqEZgpd+
6gOEk3pdlR5QMRgs0ijBL85IR0PWusV2SX0eZk9ndCX2abRaBA88ZJbZacBeIilZ
9KYjAopAuEg6RKeweYL93hYktnxvJJ+DLxzpaf9Lz1HheOn52nQ=
=dqiR
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
