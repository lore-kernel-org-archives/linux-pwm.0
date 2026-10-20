Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501226;
	b=KAF+/5V3nsCJjbR1QnL96K4lDs4AsRnvoVhh757iJXXbrocIdfrfhof+w6Jey+aVU9Xy
	 bq/YjAEv2mmCSXGAf/vxIQ2Vlu3qu7VL75GZPEFH3ziwFviAs8MY+D1ff/rNSkWq9EukL
	 axubsgaS89SbrIn9cfLq3mWWNOc1BLia6dNYgZbGWfQ1rt3z6AeOYgBCFXbKki3+6fRFo
	 pEtYDtr7lVQKRxpz5tH3UMzOPEY2PjCZI/ZjzyTb4VlXmOLGp/d+jXVcgzWAvadyVYJyP
	 2dxRQXN7QG2DNc6qXGYB01XyWBSsly8d8GTkRIW071Fp02C0cRZJJOkGTHhhTAE/g7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=qy10MCNTYPGcfzZL52ZybsUTyOOK881ej/NFqUmLnqQ=;
	b=asPIJNKBnwHJOcFVqC9XPwLJCmLFDMyT5/5hTXNpAx0+COF3Xi9CECdqwRxhUNYJry8D
	 PdewNec+kkY3hNkAYzMZu8HZaGtOUMVs2PEPIUARFLPh0DVQSuQ7bIhhRhu2BtW950fVG
	 d0wQLSUzLoLPFR4HmnMQ431m+EW10sq/tDdU+ZHbB+kxGYpVzyxp5I31SRfgwDUMtIQYy
	 IWjcPZV3onMtIWxoHm/uYtR6JccpeTr2plJZ4aEu4i6QVbszRHpMtaZkLNB+1yomii66e
	 C0OWBkHkyInrrg0Kx1Sg/Fy5NBZE2u2+95sxUrcU9v9WI3o7qOklG/xD1oiHGPk2J0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iauC1ZCt;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CF60A3829
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9CF60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iauC1ZCt
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-487049569b6so1792760f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501224; x=1793106024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qy10MCNTYPGcfzZL52ZybsUTyOOK881ej/NFqUmLnqQ=;
        b=iauC1ZCtLJ+tB69Zq2X1S9F86cMkdFrRLjxyu/MVuWh2pK1bFBPny4DbJAZbwK5LKm
         b6shBEADPtKYVwAnKkJHpzEpxXYOAX0SLwAnHd2OH/WRq71IK898NV7MUbyoJ0i18lHU
         UolN29yCITahO0d/ipVDB9IoLqD1fFtqvtWewBJQ5/nunil8kDZRbUSkOowryvluPPho
         IYPmqnouL3YrpC98LaCw+TCsoMbNle+CzsRSW5lVhRDMHk5HqTxQZFAs+k7o9xdIzN6s
         lFivEbzR1J0yG4fUUfEGNqqsfNaIsEetXevT3LY5O0tsfczQUe+g5bAWpXv7fpAxqmFN
         yVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501224; x=1793106024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qy10MCNTYPGcfzZL52ZybsUTyOOK881ej/NFqUmLnqQ=;
        b=Y0iHsWj9UANxDjHiTfYCPE9yzEaQZQh1lODTXN8WWZZrPomUP8nOIxvVuUvn50FttH
         pYPC7O5M63zGnAWPvqwAKo9X2gVaU07+Zcv5GC/WYX/bIKryMFqb+ee/X4l43R3QT986
         0Pwqcg4ibHehxP4/6QvdWJycgDYNXHEBZ969BEAiE7w0y3GnXuTl70sgAuFIwIEX0P04
         822NdFhYs1wUkll9frnJHEyY92d/dVmNFNTrvocpocDP44jAX+E7+mIteixnKSRL2PkL
         8FtIZbC4BXIV++h18s1poWkaD0eCrFQopdLAxc5wnRzIAH4pg9fQ1RbYaibAtR98dAW5
         2e0w==
X-Forwarded-Encrypted: i=1; AKwUvBxGaNiOa10TXupsbR3p503+r0CFD9LKFEZ7LD9m428dD1cnrca1ey34be6o/yYd+ncRflnC50xdl7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkSfNHVe0SLx+G7dJrHq6/Cc3YMzEYuCI21fndhq97uaZeFYxY
	1M8Ekdi4IkBP0W3IJvlNbvtsvMxjdYX7njeihr+XVW6IetkWcm/ADIYv
X-Gm-Gg: AYBFou1vkboDAGaW7eaURkQgDmbWgTvnU1RxGY5FHXFFMknva6w6jk38y9rQL/cCWAE
	0hzMdzRLrZWLynKtgxORRjPzEp80UMPxFridYmvR2vIbIUATpHl4bCTG/j5gqZYBSTu7ds7eil3
	KUxGrtj0d2HyYChXOJHTizPxBYcf765TgDpSEG2qG9T0GOAG3BnyaAoYN793tZuXO8CjheYEhTr
	BseB7j+5CGd2RlODv3VQ74fgZ80ZPXzw64T/IBI/JzILWf7lByHCuDiqDwyuI+sDbHb1BN2yV0V
	zfVnPixvuILIl32DFYj7KlBDjPI+o+S8NaaB1Gf6t8DOc6NR0lll6uuqQ2QIRN/V3hdjraeVlgy
	CMZJxWLStyllMHPLFM4ZLhLs3tnFx9f0AqxZfVHAt8F4NpuLo7731nuog+Xi0tUGNP3VgSohFzh
	Rh13zjLJE2QlWZHZk+K19fzqH6Dv58/e+dHZt7ET6yfb6O7vJSaKa+CoAJ3Jh5f39Uxtf5nTrGF
	SDi+9Z/ZLoPWyzyRqqLBS33IWWDd1PD3JzLpgdR1eMSQ6813jU3WD9jXmNvuFk/ih/G5SSuWJY=
X-Received: by 2002:adf:e34e:0:b0:48d:b8a1:53c5 with SMTP id ffacd0b85a97d-48e07fc0ab6mr16744823f8f.56.1792501223683;
        Tue, 20 Oct 2026 06:00:23 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:23 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:15 +0200
Subject: [PATCH v3 4/8] of: unittest: Test fw_devlink with GPIO nexus maps
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-4-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Add OF unit tests that call the fw_devlink add_links operation for GPIOs
routed through nexus maps. Verify that each mapped consumer has exactly
one link to the final GPIO provider rather than to the nexus.

Also cover direct references and all GPIO property spellings recognized
by fw_devlink, including the deprecated singular and unprefixed forms.

The gpio-map routes its entries to different providers so that selecting
the wrong entry is caught as well.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
v3: Route gpio-map entries to two providers, use a middle entry (Herve)
v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com
---
 drivers/of/unittest-data/tests-phandle.dtsi | 39 +++++++++++++++
 drivers/of/unittest.c                       | 75 +++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 554a996b2ef1..f5d7ee072c90 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -79,6 +79,45 @@ consumer-b {
 				phandle-list-bad-args = <&provider2 1 0>,
 							<&provider4 0>;
 			};
+
+			fw-devlink-tests {
+				gpio_provider_a: gpio-controller-a {
+					#gpio-cells = <2>;
+				};
+
+				gpio_provider_b: gpio-controller-b {
+					#gpio-cells = <2>;
+				};
+
+				fwdevlink_nexus: nexus {
+					#gpio-cells = <2>;
+					gpio-map = <1 0 &gpio_provider_a 3 0>,
+						   <2 0 &gpio_provider_b 5 0>,
+						   <3 0 &gpio_provider_a 7 0>;
+					gpio-map-mask = <0xffffffff 0>;
+					gpio-map-pass-thru = <0 0xffffffff>;
+				};
+
+				gpio-compat-consumer {
+					gpios = <&fwdevlink_nexus 2 1>;
+				};
+
+				gpio-compat-singular-consumer {
+					gpio = <&fwdevlink_nexus 2 1>;
+				};
+
+				gpio-consumer {
+					test-gpios = <&fwdevlink_nexus 2 1>;
+				};
+
+				gpio-direct-consumer {
+					test-gpios = <&gpio_provider_a 1 0>;
+				};
+
+				gpio-singular-consumer {
+					test-gpio = <&fwdevlink_nexus 2 1>;
+				};
+			};
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e255f54f4d76..f15c110dbf4d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -10,6 +10,7 @@
 #include <linux/dma-direct.h> /* to test phys_to_dma/dma_to_phys */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/fwnode.h>
 #include <linux/hashtable.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
@@ -710,6 +711,79 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	}
 }
 
+static void __init of_unittest_fw_devlink_supplier(struct device_node *tests,
+						   const char *consumer_name,
+						   const char *supplier_name)
+{
+	struct device_node *consumer, *supplier;
+	struct fwnode_handle *consumer_fwnode;
+	struct fwnode_link *link;
+	unsigned int link_count = 0;
+	bool found = false;
+	int rc;
+
+	consumer = of_get_child_by_name(tests, consumer_name);
+	supplier = of_get_child_by_name(tests, supplier_name);
+	if (unittest(consumer && supplier, "missing consumer %s or supplier %s\n",
+		     consumer_name, supplier_name))
+		goto put_nodes;
+
+	consumer_fwnode = of_fwnode_handle(consumer);
+	fwnode_links_purge(consumer_fwnode);
+	rc = fwnode_call_int_op(consumer_fwnode, add_links);
+	if (rc == -EOPNOTSUPP) {
+		pr_info_once("fw_devlink tests skipped: OF supplier links are not supported\n");
+		goto purge_links;
+	}
+	if (unittest(!rc, "failed to add links for %pOF: %d\n", consumer, rc))
+		goto purge_links;
+
+	/*
+	 * The suppliers list should normally be accessed with fwnode_link_lock
+	 * held, but that lock is private to the driver core. These test nodes
+	 * are isolated and have no concurrent link updates.
+	 */
+	list_for_each_entry(link, &consumer_fwnode->suppliers, c_hook) {
+		link_count++;
+		if (link->supplier == of_fwnode_handle(supplier))
+			found = true;
+	}
+
+	unittest(link_count == 1, "%pOF has %u suppliers, expected 1\n", consumer, link_count);
+	unittest(found, "%pOF is not linked to supplier %pOF\n", consumer, supplier);
+
+purge_links:
+	fwnode_links_purge(consumer_fwnode);
+put_nodes:
+	of_node_put(consumer);
+	of_node_put(supplier);
+}
+
+static void __init of_unittest_fw_devlink(void)
+{
+	static const struct {
+		const char *consumer;
+		const char *supplier;
+	} cases[] = {
+		{ "gpio-compat-consumer", "gpio-controller-b" },
+		{ "gpio-compat-singular-consumer", "gpio-controller-b" },
+		{ "gpio-consumer", "gpio-controller-b" },
+		{ "gpio-direct-consumer", "gpio-controller-a" },
+		{ "gpio-singular-consumer", "gpio-controller-b" },
+	};
+	struct device_node *tests;
+	int i;
+
+	tests = of_find_node_by_path("/testcase-data/phandle-tests/fw-devlink-tests");
+	if (unittest(tests, "missing fw_devlink test data\n"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++)
+		of_unittest_fw_devlink_supplier(tests, cases[i].consumer, cases[i].supplier);
+
+	of_node_put(tests);
+}
+
 static void __init of_unittest_property_string(void)
 {
 	const char *strings[4];
@@ -4533,6 +4607,7 @@ static int __init of_unittest(void)
 	of_unittest_dynamic();
 	of_unittest_parse_phandle_with_args();
 	of_unittest_parse_phandle_with_args_map();
+	of_unittest_fw_devlink();
 	of_unittest_printf();
 	of_unittest_property_string();
 	of_unittest_property_copy();

-- 
2.43.0

