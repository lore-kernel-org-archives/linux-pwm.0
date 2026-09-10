Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8548EC67
	for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049813; cv=none; b=VceX2oSbvhrXVOzfbvQaoW3/f9LWorqKkTVohodL1SVPxiQEX1Oz6AGD5Pyp0ARrjt8Fn9d7bJtmiihb7xkGMJMW2WjLS/6OGE7MVCYoV1kkpNQ26z43/xNItISo1a6KWH453pGmuZ0XanLP9w+O6Rw3XcNXCpDlQy3kVboNZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049813; c=relaxed/simple;
	bh=f+oWL0l2lQ4U824rI7f2G+wEgBL0XsHytujTRnyC4Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqDttCEj/x1vdqBPiN1Qx9Jkx8kkn3BaBxXY7tRAtipe8LV3nJv5/P216aUxRYleK/CjzQMajjIfv4c/A3/R0hLiYlfD3EbG7k7XqFs3DqE+VbhvKmiTWY2E7rYI/0gfJ0h2e1VgqCU85R/ruAJAJcrx1k+KRWAij7aCdbpH2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoA3lIu0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoA3lIu0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so70274875e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049810; x=1789654610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7pblcn7/kuaqKjgHIuNVXFQ3fC4U6ULeesMxuIl3oA=;
        b=SoA3lIu02V/+HIQIJPbl1OTBto7tEri+nXWpDjgW9ky9I9ucv1dUFtJ/Nn/7XidKc2
         vyJqZjKS9KjOJsGy0ixIw0XPyFN7G1sZNkwj+m4sbtOG1E80a+mgMhe+BKm8pIYuJnwL
         DX+mBfqd0gBXV6b4mH+TEH9iK8qumE/ewEsvSsQbM+ga04weCgzFzg+sCr20nbQTWFZX
         XvTkKz4jBL89Z4G6vTbzYP/JFHiuD3XHEqMQh7CZ87wDeoawiQasZHoynaFvsoAz6JdL
         8A0DeaY7FN7pmrMSNOpGarEIsodrBjYEcF53adw0OjsjeTqJSiK8AG2ZahIXVmYgs+XC
         hY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049810; x=1789654610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7pblcn7/kuaqKjgHIuNVXFQ3fC4U6ULeesMxuIl3oA=;
        b=bhdeQdBCVhFyOiuNnhryyj/1n8mc+aTPZGi/F6OWntcwEMfc8RIRW9oPaxEoVEVVpX
         3HIvqirqQAebcD9FgCXeEtU/I4p/3D00IhFQA74ozDHW7jUuDlPiY6laxble7jQv8tGG
         utebsVtEDlNaWJ8Tjqpp4W03B+EFGlvEAmx9Xu3oUaZDbhJWfHQUUiAVXVRA9bLQzN5e
         mIyVrmAnaDFmAN5f/pi0eCiGdevRnDUoflPKujK4UnQsxKN00mbFnLg4xT8Y1LjE0CBb
         1Fj56n+PI+I0fDJkYYXZLTz4gTYSDXrbmDiq+3pyhrvZAzhJeMvr7+n9v/AjqgtVGAWz
         biOg==
X-Forwarded-Encrypted: i=1; AKwUvBwDTa6MoejaWNr65MuG1jdH3yGnJn0DQEBXgkmhnWdUHkEI1L5hodhF8zI9DqiCNwcBcDg+1DSekSI=@vger.kernel.org
X-Gm-Message-State: AFuF++nK315cNCZ9t9riDuxtKC7SBgv34QaEM7tjfAAEgtMq72ErhDC8
	c2vwf9e9Ihk6ykZBE3IlGG7xkH9iUc7BY6cKBq2w+fAEFm+mOwxGFJ8X
X-Gm-Gg: AYBFou3boj1gDUE5xRf9WZtWpViXDujq0hD8fPCmgsSwVlnSHSTMSXgEwJ0CXDId4rH
	n86CzrHPYfIlFQByxQq3jgux9TrknfTL7frh3CAgN56gtBruLNkAwlkvyVqVcjIIb19lvipC7gc
	TNSwm11lDnqUBG+0CNLdKp92ZKT1On+4DPMG/9JB500pL0pvCZXVHv4UNAmh39W68EwOoo87P7i
	K0mCorVhs8jbufa8QtwcxfrMnD9LUjEjdfHLGY9vmCX4jIeFT3a3svDnmUWkz3b/F8CKz54dbYm
	ClTbTJHv2dSs4a+V6d9s57aUUF8ckcACRKM0gQRCSPEg/MHlQdAHVnyISsXu6oKAVMQRlKmYU9w
	+kZbRbg5YaqEVgTJkG9zy8035YYbsDaQPwy/rNdF6V4gnd6ahE4fMjVlv0/0es7o3qRboZE7dzE
	SFkz9/yfVq9OUOUC4vZFhN44B1Pnr67Y4jkVgtoPLN82GCK6GjbmEU+PKQLvqqJs0l+eSkh0nsx
	QGYHYw2cLHIoSzeI1+cNAQdxjxGAdBABvz1lc6tPG1k7vpjtWg5Ob5F14VkrtNNuQISo+YN0w==
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr328667225e9.14.1789049809381;
        Thu, 10 Sep 2026 07:16:49 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm293895575e9.4.2026.09.10.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:16:48 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 10 Sep 2026 16:16:42 +0200
Subject: [PATCH v2 1/7] of: property: fw_devlink: Follow GPIO nexus maps
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-fw-devlink-nexus-ready-v2-1-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
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
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

GPIO consumers use of_parse_phandle_with_args_map() to resolve
specifiers through gpio-map properties. fw_devlink instead parses GPIO
properties as direct phandle references, so it records the nexus node as
the supplier rather than the mapped GPIO provider.

A nexus is a translation node, not the GPIO provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for all supported GPIO property spellings. This
makes fw_devlink resolve the same provider as the GPIO consumer API.
Direct GPIO references continue to work because the map-aware parser
returns the original provider when no gpio-map property is present.

Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt-parent, dmas and -gpio(s)")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..380df0861ab9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1311,6 +1311,19 @@ static struct device_node *parse_prop_cells(struct device_node *np,
 	return sup_args.np;
 }
 
+static struct device_node *parse_nexus_prop(struct device_node *np,
+					    const char *prop_name, int index,
+					    const char *stem_name)
+{
+	struct of_phandle_args sup_args;
+
+	if (of_parse_phandle_with_args_map(np, prop_name, stem_name, index,
+					   &sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
 #define DEFINE_SIMPLE_PROP(fname, name, cells)				  \
 static struct device_node *parse_##fname(struct device_node *np,	  \
 					const char *prop_name, int index) \
@@ -1361,6 +1374,15 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 	return parse_suffix_prop_cells(np, prop_name, index, suffix, cells); \
 }
 
+#define DEFINE_SUFFIX_NEXUS_PROP(fname, suffix, stem)			     \
+static struct device_node *parse_##fname(struct device_node *np,	     \
+					const char *prop_name, int index)    \
+{									     \
+	if (!strends(prop_name, suffix))				     \
+		return NULL;						     \
+	return parse_nexus_prop(np, prop_name, index, stem);		     \
+}
+
 /**
  * struct supplier_bindings - Property parsing functions for suppliers
  *
@@ -1416,7 +1438,7 @@ DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
-DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
+DEFINE_SUFFIX_NEXUS_PROP(gpio, "-gpio", "gpio")
 
 static struct device_node *parse_pinctrl_n(struct device_node *np,
 					   const char *prop_name, int index)
@@ -1436,8 +1458,10 @@ static struct device_node *parse_gpios(struct device_node *np,
 	if (strends(prop_name, ",nr-gpios"))
 		return NULL;
 
-	return parse_suffix_prop_cells(np, prop_name, index, "-gpios",
-				       "#gpio-cells");
+	if (!strends(prop_name, "-gpios"))
+		return NULL;
+
+	return parse_nexus_prop(np, prop_name, index, "gpio");
 }
 
 static struct device_node *parse_iommu_maps(struct device_node *np,
@@ -1452,8 +1476,6 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
 static struct device_node *parse_gpio_compat(struct device_node *np,
 					     const char *prop_name, int index)
 {
-	struct of_phandle_args sup_args;
-
 	if (strcmp(prop_name, "gpio") && strcmp(prop_name, "gpios"))
 		return NULL;
 
@@ -1464,11 +1486,7 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 	if (of_property_read_bool(np, "gpio-hog"))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", index,
-				       &sup_args))
-		return NULL;
-
-	return sup_args.np;
+	return parse_nexus_prop(np, prop_name, index, "gpio");
 }
 
 static struct device_node *parse_interrupts(struct device_node *np,

-- 
2.43.0

