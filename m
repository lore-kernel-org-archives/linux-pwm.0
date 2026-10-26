Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990790;
	b=4UYgE4bU8ZJiQTU0fIur4dN6uPPabqZTQ+kwaUwwwDAYTQ9MjXFZTor2won3hv6q4Tdz
	 QiK4manxLe7kK5+++ZY/t+DK3dGjoetpXvrgyxvQYnNRrJ9wiHioFthGtypjxP9c4DU2r
	 3NDntGOwc3KgOfaQYWHrPBnup6++OTSToxEFV2MrIw36GD+aPX8sYJTjirlrysJztALah
	 XUrmgMo9IqIudPphO2rltu8RyfIROJjc/FpmKpF9fto1S+RELDC+zU+N5s8PZLm2CE1P5
	 9CTj8fSglmH2URJoMGBwpnR7vwfuJW6ylxw+NDii50OX2/7EHt14ofWdSP+sxLZlNiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990790;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NLmt/AZKtREcaDKgDQ5NlYZMhl4LgJCsucH6I4F3Shw=;
	b=GaZvjeTdJjqRzaup1NzDWRqzLPqBd9jdoqJvMpHn8L0NxE/6jOWAWMkcLx5oLHM2qBRz
	 Hj2Qq6OA90abOd7bEpbwPwEbO6TU0ENEA8lednVOxS8DDi5uvA2RUTb2qMoW5MhaRIiaz
	 p3YAU1zXXsgDjC8kHEYENK2PiCNs35PvgXejpLS0vcMWdqu+yNPDbJWT94ssm1VACdT/s
	 cz9puRq2W20uh9iEZwbZX2kETFcZdr8f2oB0w6IP4Pq1E/V+nvP/EWfM2DiY/Swor6jv5
	 a9vKmCRqjVWSS4mn5fmk8tPglQBMoW5dhAYP9NHzz33qNAmRByfRrz/m+g+1GnTqnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWdb2xS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C395606A31B
	for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWdb2xS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2701F031E7
	for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 04:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792990789;
	bh=NLmt/AZKtREcaDKgDQ5NlYZMhl4LgJCsucH6I4F3Shw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EWdb2xS9oApBjg6p4ixceDJP4tSn2ThGDTvC15VYpUt6HTPFG9HSua/JRoRQNf4Ad
	 3my1oSTlvTDcqr8JI93hLcbdXxMRWE9BIrWViKyhR5jfvH3eK1uxm+DrsxvIg4HXkg
	 aezUSpZffI7eKg/WRfU3ofk156e7lKFohlPpmyJWGacg2TvhjZj4Kn1kun4EOXQRa6
	 d4NTypTpEM6qYx6WL2BqtZkS/yB5mVfbSCS1lyXlaQ4ZBIutquqh7yJ67GmiSGPPGM
	 htxDsN03VPFt1kvtZfqd21a5ruB8iMryMsqBBOQ8UAfN+haQfbeBbc+ttWkmCeEaKp
	 UTv5C+Omv/Kzg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3697032a12.1
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 21:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7Rbbo2SCFN7n7i1vnfFEm0hxsguE1vcrSln1N8LFqXjxOSZzVH/pT8sOWJI5GLC2ebmPjTcehWOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn3OKmMYD2mK4tN7gdwxRGvEiQ+MXl6PKFOe452j7AHVddNvhC
	bLd591x+bfoTfTN4M/IpvgnhaCPoWLPQTLkfBmsXyJshyN2r+jl2I2sx6Cds7JwS04/jeM3Wz9f
	p+NNMQw1fp4Quay9PswyXiF2/ND7yvs8=
X-Received: by 2002:a05:6402:e08:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b443a2fee7mr6790635a12.10.1792990787933; Sun, 25 Oct 2026
 21:59:47 -0700 (PDT)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 25 Oct 2026 21:59:36 -0700
X-Gmail-Original-Message-ID: <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>
X-Gm-Features: AclHuK9u7vjAQCLxUR5sEBpiJHi39rWIfcPdQhFAQgsEzk2KJz-ZGO2-0-6Y7xs
Message-ID: <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] of: property: Make fw_devlink follow GPIO, PWM and
 clock nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:00=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> This series fixes an fw_devlink supplier-resolution problem reported by
> Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
> resources routed through an LVDS connector. Consumers referencing the
> nexus could remain deferred because fw_devlink linked them to the nexus
> rather than to the providers selected by gpio-map and pwm-map. [1]
>
> GPIO, PWM and clock consumer APIs use of_parse_phandle_with_args_map()
> to resolve specifiers through gpio-map, pwm-map and clock-map
> properties. The corresponding fw_devlink parsers use direct phandle
> parsing instead. Given a consumer which references a nexus, the consumer
> API and fw_devlink therefore resolve the reference to different nodes:
>
>   consumer API:  consumer -> nexus -> mapped provider
>   fw_devlink:    consumer -> nexus
>
> A nexus is a translation node rather than the resource provider and need
> not have a driver. The link to it can consequently remain unresolved and
> defer the consumer even though the mapped provider is available.
>
> Make the fw_devlink GPIO, PWM and clock parsers use the same map-aware
> resolver as their consumer APIs. The resolver also handles valid direct
> references by returning the original provider when no map is present.
> Use dedicated exact-name and suffix declaration macros to opt these
> bindings into map-aware parsing without changing unrelated property
> parsers. Retain GPIO's existing exclusions and compatibility handling.
>
> Since fw_devlink runs the resolver for every consumer when its device is
> created, patch 1 first fixes a stack buffer overflow in the resolver
> when the provider referenced by the consumer has more than
> MAX_PHANDLE_ARGS cells.
>
> The regression tests call the OF add_links operation and verify that a
> mapped reference creates exactly one link to the provider selected by
> the referenced map entry, not to the nexus. They also cover valid direct
> references. The GPIO tests exercise all property spellings recognized by
> fw_devlink, including the deprecated singular and unprefixed forms.
>
> The clock patch fixes aacc54c67869 ("clk: Add support for clock nexus dt
> bindings"), which has been in clk-next and linux-next with the same hash
> since next-20260907. There is no build-time dependency on it, but the
> clock patch should not reach mainline before it. The series applies to
> next-20261014.
>
> Tested with:
>   - The CONFIG_OF_UNITTEST cases under QEMU/x86_64: all passed. With the
>     fw_devlink parser changes reverted, exactly the six mapped consumer
>     cases fail.
>   - W=3D1 builds of each patch on arm64, including the OF unittest data
>   - Toradex Verdin iMX8M Plus hardware using a connector nexus for the
>     display GPIO and PWM resources (v2, same fw_devlink changes): the
>     display probes successfully
>
> [1] https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jba=
uradujrre@gc5nbdhhixaf/

Thanks for the patch series to keep this updated! Took a close look at
all the patches and they mostly look good.

Left some minor comments. Should be easy to address/clarify.

When they are addressed:
Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks,
Saravana

>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> ---
> Changes in v3:
> - New patch 1 fixing a stack overflow in
>   of_parse_phandle_with_args_map() (Uwe)
> - Tests: route map entries to different providers and reference a
>   non-first entry with non-zero cells (Herve)
> - Collected R-b tags
> - Rebased onto next-20261014
> - Link to v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v=
2-0-17ac82dbe226@toradex.com
>
> Changes in v2:
> - Split the unit tests into per-resource follow-up commits
> - Added clock nexus as well because the clock nexus series was merged:
>   https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream=
-v5-0-8785f9531cf0@bootlin.com/
> - Link to v1: https://lore.kernel.org/r/20260902-fw-devlink-nexus-ready-v=
1-0-68fe1996e78a@toradex.com
>
> ---
> Ernest Van Hoecke (8):
>       of: base: Fix stack overflow in of_parse_phandle_with_args_map()
>       of: property: fw_devlink: Follow GPIO nexus maps
>       of: property: fw_devlink: Report unsupported supplier linking
>       of: unittest: Test fw_devlink with GPIO nexus maps
>       of: property: fw_devlink: Follow PWM nexus maps
>       of: unittest: Test fw_devlink with PWM nexus maps
>       of: property: fw_devlink: Follow clock nexus maps
>       of: unittest: Test fw_devlink with clock nexus maps
>
>  drivers/of/base.c                           |  5 ++
>  drivers/of/property.c                       | 53 ++++++++++++++-----
>  drivers/of/unittest-data/tests-phandle.dtsi | 81 +++++++++++++++++++++++=
++++++
>  drivers/of/unittest.c                       | 79 +++++++++++++++++++++++=
+++++
>  4 files changed, 205 insertions(+), 13 deletions(-)
> ---
> base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> change-id: 20260901-fw-devlink-nexus-ready-c859706b019d
>
> Best regards,
> --
> Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
