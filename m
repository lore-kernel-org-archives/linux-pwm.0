Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990471;
	b=IB/pxFjjV2KjjB3RIaxl6sZnSNBlIGT2bZScqeBMSiXlaJJ5Rv/iOr5zV3lNxnGUw73m
	 l6KsPIf4uWW1oet2WTnL8jrEwOcitB6KBD757wJx7IlqPZ2QYmaTDc/XShzG5uYKXjj3K
	 hkgCYFv5UiWc5w9dBI9jKqmyiSjU4mjbMgng9weW6BmlEGGVFBs2a2fWeQ6aoHFCYcmLK
	 ilzXXz+negRWe8kho2izL33zRM1/H1h5NrwL6KRRB8MLrpPdSYe7sVIlgdps4ClBZuNRK
	 8vRYpRNHVgja1GXsT5s8MXheArmqf/3S1SRoZcZfvf5Lumhi3jzBFAsTOX3bn/kLr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990471;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=d+db6cO4/znRKfCwcArWJfMZVzu/oUp97IX1g7WQ5po=;
	b=Gh4vzW7QOH6g3P/3You//xzLavYR1+Xkvieq7GGNAb8zFqsAxmUSSlPrxJ9vLqzx5Fdp
	 GMMa1Ko/du7hw3ZkoS8+IYUeJBeV+6X0oBFLEDTsuPLA60LBWRdMkhGoA3AGrdEbCvgZU
	 kHyiTlyYvaEGJn75JMFvrM4rnTEBtfMlXJsTbCGKdaniJfH/U2u8DnrTpJ5n5v6ickMnA
	 A0BTM66lm0YDF2zguEJPfalWVeNmtiPM2NqnqcFsNIn4Q9DinY0+1pRK73wVK64m/shn5
	 ol5FXO7mx/KZAEMgdoYxRTPWUGQEWXdDOOGoqc0qs1PTeWSFXiWtug+9GXWU9euFvtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSRPfVy4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3293606A31B
	for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSRPfVy4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F11F031EE
	for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 04:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792990470;
	bh=d+db6cO4/znRKfCwcArWJfMZVzu/oUp97IX1g7WQ5po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PSRPfVy4z2jMdwgAqoA9TAR+1OUd38kw40YdqDTDNSfNd/wSSLHr+JkGCOkg8eQ+6
	 FYGh7UDIxv0rakCO2oPE0lI7Ag5TXyfS6fo3mpLCfLrJ2scvLJKULqcne0kXeRDqRK
	 t81jcTSqcPe+Xns6wS7WNEvMN4eluGs78bfIQf8jkOc5oBzsovXTropD2oUQ3W30IS
	 N8D0mj2zytaYs1AHegst1Tv4qGwqp96r74ACYxgOhVPXT1JYbDUrbm/Zvm5xaCNQtB
	 f2QJSIMlZuhbK/0+igkTg6+qA7NWe8qmzdLd8GxBOwwLWXiVXZLZCEYfi6Q0eXUNHl
	 vLQ0XI4a2IpIg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so3107929a12.1
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 21:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByP3FKyhlQ7gsSOuG74X8XAfENuXKgL/hHrEKfHlCsnBWxB0rscxh8DxDB5HQqQi/jnUuDujMeJD4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLdcq+rzDHZm+BDM500Ij1P8weACUkVjvKTXn2S8YSWHW5BY2h
	cD3Ln5RCOZnaS6VWOw9+6GiSFZ0u7Uy5qIV6fjwqWYXxVU7xwBD7x0W9xMfMQF2ZU0syBXDH2s+
	FICf+2wCdRMUlNsiF4G5vGYIINXegDJQ=
X-Received: by 2002:a05:6402:1945:b0:6b3:f7f6:649e with SMTP id
 4fb4d7f45d1cf-6b44311a75emr6070392a12.7.1792990469315; Sun, 25 Oct 2026
 21:54:29 -0700 (PDT)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com> <20261020-fw-devlink-nexus-ready-v3-4-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-4-fd6f1c17e16d@toradex.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 25 Oct 2026 21:54:17 -0700
X-Gmail-Original-Message-ID: <CACRMN=eGqVa8ObETW8x_EVPzn6kY=kKGyOqAj5Et8iy_yVY75A@mail.gmail.com>
X-Gm-Features: AclHuK9taTxVHM675uQiYSXXFu84ZUo78YYFrIOFAacwqHamv6y8a9Wqx5PMgKU
Message-ID: <CACRMN=eGqVa8ObETW8x_EVPzn6kY=kKGyOqAj5Et8iy_yVY75A@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] of: unittest: Test fw_devlink with GPIO nexus maps
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:00=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> Add OF unit tests that call the fw_devlink add_links operation for GPIOs
> routed through nexus maps. Verify that each mapped consumer has exactly
> one link to the final GPIO provider rather than to the nexus.
>
> Also cover direct references and all GPIO property spellings recognized
> by fw_devlink, including the deprecated singular and unprefixed forms.
>
> The gpio-map routes its entries to different providers so that selecting
> the wrong entry is caught as well.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> v3: Route gpio-map entries to two providers, use a middle entry (Herve)
> v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-3-17ac82=
dbe226@toradex.com
> ---
>  drivers/of/unittest-data/tests-phandle.dtsi | 39 +++++++++++++++
>  drivers/of/unittest.c                       | 75 +++++++++++++++++++++++=
++++++
>  2 files changed, 114 insertions(+)
>
> diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/uni=
ttest-data/tests-phandle.dtsi
> index 554a996b2ef1..f5d7ee072c90 100644
> --- a/drivers/of/unittest-data/tests-phandle.dtsi
> +++ b/drivers/of/unittest-data/tests-phandle.dtsi
> @@ -79,6 +79,45 @@ consumer-b {
>                                 phandle-list-bad-args =3D <&provider2 1 0=
>,
>                                                         <&provider4 0>;
>                         };
> +
> +                       fw-devlink-tests {
> +                               gpio_provider_a: gpio-controller-a {
> +                                       #gpio-cells =3D <2>;
> +                               };
> +
> +                               gpio_provider_b: gpio-controller-b {
> +                                       #gpio-cells =3D <2>;
> +                               };
> +
> +                               fwdevlink_nexus: nexus {
> +                                       #gpio-cells =3D <2>;
> +                                       gpio-map =3D <1 0 &gpio_provider_=
a 3 0>,
> +                                                  <2 0 &gpio_provider_b =
5 0>,
> +                                                  <3 0 &gpio_provider_a =
7 0>;
> +                                       gpio-map-mask =3D <0xffffffff 0>;
> +                                       gpio-map-pass-thru =3D <0 0xfffff=
fff>;
> +                               };
> +
> +                               gpio-compat-consumer {
> +                                       gpios =3D <&fwdevlink_nexus 2 1>;
> +                               };
> +
> +                               gpio-compat-singular-consumer {
> +                                       gpio =3D <&fwdevlink_nexus 2 1>;
> +                               };
> +
> +                               gpio-consumer {
> +                                       test-gpios =3D <&fwdevlink_nexus =
2 1>;
> +                               };
> +
> +                               gpio-direct-consumer {
> +                                       test-gpios =3D <&gpio_provider_a =
1 0>;
> +                               };
> +
> +                               gpio-singular-consumer {
> +                                       test-gpio =3D <&fwdevlink_nexus 2=
 1>;
> +                               };
> +                       };
>                 };
>         };
>  };
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index e255f54f4d76..f15c110dbf4d 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-direct.h> /* to test phys_to_dma/dma_to_phys */
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/fwnode.h>
>  #include <linux/hashtable.h>
>  #include <linux/libfdt.h>
>  #include <linux/of.h>
> @@ -710,6 +711,79 @@ static void __init of_unittest_parse_phandle_with_ar=
gs_map(void)
>         }
>  }
>
> +static void __init of_unittest_fw_devlink_supplier(struct device_node *t=
ests,
> +                                                  const char *consumer_n=
ame,
> +                                                  const char *supplier_n=
ame)
> +{
> +       struct device_node *consumer, *supplier;
> +       struct fwnode_handle *consumer_fwnode;
> +       struct fwnode_link *link;
> +       unsigned int link_count =3D 0;
> +       bool found =3D false;
> +       int rc;
> +
> +       consumer =3D of_get_child_by_name(tests, consumer_name);
> +       supplier =3D of_get_child_by_name(tests, supplier_name);
> +       if (unittest(consumer && supplier, "missing consumer %s or suppli=
er %s\n",
> +                    consumer_name, supplier_name))
> +               goto put_nodes;
> +
> +       consumer_fwnode =3D of_fwnode_handle(consumer);
> +       fwnode_links_purge(consumer_fwnode);

Why this line? Aren't you controlling the exact set of properties in
the test nodes?

-Saravana

> +       rc =3D fwnode_call_int_op(consumer_fwnode, add_links);
> +       if (rc =3D=3D -EOPNOTSUPP) {
> +               pr_info_once("fw_devlink tests skipped: OF supplier links=
 are not supported\n");
> +               goto purge_links;
> +       }
> +       if (unittest(!rc, "failed to add links for %pOF: %d\n", consumer,=
 rc))
> +               goto purge_links;
> +
> +       /*
> +        * The suppliers list should normally be accessed with fwnode_lin=
k_lock
> +        * held, but that lock is private to the driver core. These test =
nodes
> +        * are isolated and have no concurrent link updates.
> +        */
> +       list_for_each_entry(link, &consumer_fwnode->suppliers, c_hook) {
> +               link_count++;
> +               if (link->supplier =3D=3D of_fwnode_handle(supplier))
> +                       found =3D true;
> +       }
> +
> +       unittest(link_count =3D=3D 1, "%pOF has %u suppliers, expected 1\=
n", consumer, link_count);
> +       unittest(found, "%pOF is not linked to supplier %pOF\n", consumer=
, supplier);
> +
> +purge_links:
> +       fwnode_links_purge(consumer_fwnode);
> +put_nodes:
> +       of_node_put(consumer);
> +       of_node_put(supplier);
> +}
> +
> +static void __init of_unittest_fw_devlink(void)
> +{
> +       static const struct {
> +               const char *consumer;
> +               const char *supplier;
> +       } cases[] =3D {
> +               { "gpio-compat-consumer", "gpio-controller-b" },
> +               { "gpio-compat-singular-consumer", "gpio-controller-b" },
> +               { "gpio-consumer", "gpio-controller-b" },
> +               { "gpio-direct-consumer", "gpio-controller-a" },
> +               { "gpio-singular-consumer", "gpio-controller-b" },
> +       };
> +       struct device_node *tests;
> +       int i;
> +
> +       tests =3D of_find_node_by_path("/testcase-data/phandle-tests/fw-d=
evlink-tests");
> +       if (unittest(tests, "missing fw_devlink test data\n"))
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cases); i++)
> +               of_unittest_fw_devlink_supplier(tests, cases[i].consumer,=
 cases[i].supplier);
> +
> +       of_node_put(tests);
> +}
> +
>  static void __init of_unittest_property_string(void)
>  {
>         const char *strings[4];
> @@ -4533,6 +4607,7 @@ static int __init of_unittest(void)
>         of_unittest_dynamic();
>         of_unittest_parse_phandle_with_args();
>         of_unittest_parse_phandle_with_args_map();
> +       of_unittest_fw_devlink();
>         of_unittest_printf();
>         of_unittest_property_string();
>         of_unittest_property_copy();
>
> --
> 2.43.0
>
