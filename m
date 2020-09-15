Return-Path: <SRS0=f22J=CY=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABBAC43461
	for <linux-pwm@archiver.kernel.org>; Tue, 15 Sep 2020 00:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1166208DB
	for <linux-pwm@archiver.kernel.org>; Tue, 15 Sep 2020 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600128429;
	bh=687u1BUQg/1ZmnPl6dLZ+wNLHLAr+aXXJgaQZx/yQZ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xzqWZhgE6ZafVuC30E11GnztoNbUTdQnH2WzYSiim7KgmuCDMPMG2BzJuFKwj4a9g
	 MtdwWa1zh84X7T83yNisC/ipzHrOICnU9AP6jkEABvIE5QUho8Af/P87BAj0NUcNnA
	 gIywvWUEbr647hwe4T/5kke4QSqWsbrzO/JdBeoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgIOAHD (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgIOAHC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 14 Sep 2020 20:07:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53530208DB;
        Tue, 15 Sep 2020 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600128421;
        bh=687u1BUQg/1ZmnPl6dLZ+wNLHLAr+aXXJgaQZx/yQZ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fCupoy2yZi1b6Lon2fshR3NSKREDyGmA8OXZZ7nkc8e9fHSbXXXzzvQWnR27mYkZ/
         /UXWPHwy7KxvlYyhm8h1QnPCb+Z5SkjR72zmGqznIBzh9OGOI8duUmba83ZR+djuxq
         wwAib1y1b3pUN10aSoObe7D152uPGBFdt7WsXPvM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1599734644-4791-2-git-send-email-sagar.kadam@sifive.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com> <1599734644-4791-2-git-send-email-sagar.kadam@sifive.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: fu540: prci: convert PRCI bindings to json-schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
To:     Sagar Kadam <sagar.kadam@sifive.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 14 Sep 2020 17:07:00 -0700
Message-ID: <160012842007.4188128.14895985041717484631@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Sagar Kadam (2020-09-10 03:44:02)
> diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.ya=
ml b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
> new file mode 100644
> index 0000000..49386cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sifive/fu540-prci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive FU540 Power Reset Clock Interrupt Controller (PRCI)
> +
> +maintainers:
> +  - Sagar Kadam <sagar.kadam@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +
> +description:
> +  On the FU540 family of SoCs, most system-wide clock and reset integrat=
ion
> +  is via the PRCI IP block.
> +  The clock consumer should specify the desired clock via the clock ID
> +  macros defined in include/dt-bindings/clock/sifive-fu540-prci.h.
> +  These macros begin with PRCI_CLK_.
> +
> +  The hfclk and rtcclk nodes are required, and represent physical
> +  crystals or resonators located on the PCB.  These nodes should be pres=
ent
> +  underneath /, rather than /soc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sifive,fu540-c000-prci
> +    description:
> +      Should have "sifive,<soc>-prci", only one value is supported

Drop description and have=20

    compatible:
      const: sifive,fu540-c000-prci

> +
> +  reg:
> +    maxItems: 1
> +    description: Describe the PRCI's register target physical address re=
gion

Drop description.

> +
> +  clocks:
> +    description:
> +      Should point to the hfclk device tree node and the rtcclk device t=
ree node.

s/device tree node//g

> +      The RTC clock here is not a time-of-day clock, but is instead a hi=
gh-stability
> +      clock source for system timers and cycle counters.

Better to have:

    clocks:
      items:
        - const: high frequency clock
	- const: RTC clock

Can you add clock-names too? Making it optional is OK.

> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    //hfclk and rtcclk present under /, in PCB-specific DT data
> +    hfclk: hfclk {
> +      #clock-cells =3D <0>;
> +      compatible =3D "fixed-clock";
> +      clock-frequency =3D <33333333>;
> +      clock-output-names =3D "hfclk";
> +    };

Add a newline here?

> +    rtcclk: rtcclk {
> +      #clock-cells =3D <0>;
> +      compatible =3D "fixed-clock";
> +      clock-frequency =3D <1000000>;
> +      clock-output-names =3D "rtcclk";
> +    };

These may not be necessary either, just have the clock-controller node
reference phandles?

> +
> +    //under /soc, in SoC-specific DT data

Don't think this comment is necessary.

> +    prci: clock-controller@10000000 {
> +      compatible =3D "sifive,fu540-c000-prci";
> +      reg =3D <0x10000000 0x1000>;
> +      clocks =3D <&hfclk>, <&rtcclk>;
> +      #clock-cells =3D <1>;
> +    };
