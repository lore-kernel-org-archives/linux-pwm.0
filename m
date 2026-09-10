Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314149CF53
	for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049822; cv=none; b=lNwj43fjIrGpziQX7zfIaiknQ77/v9VYoMGZcihgys5LATFTvTmgPu96haqdtjVbxBKXZYms12vz/qw6FGQ9sllWJGWGaroNheSYduMzth0u+0v8XcKgD+UgJleWcYeIPxkw2MGEJb/q7n/4eiNtqn7j13Tt3OImIJ9IbRCBvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049822; c=relaxed/simple;
	bh=CjNNNaVv9KXfLBZwpOPF/OJsIKss3hZhjwJRSj/WrbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDroeY7qRggsXYHtBkBHe4hZCk0/Bqpn1HhA7TzId2fS8JQku4Jd5FhyRMGnh14CxRIVj3COuLTlttlWFi+RLns/zeWmicaoOMT3Hoc2nXxj8fkaiucC5HikP7FWi3LDKimfxbaMB3zvi6YBb0igW5o9xwDmAHMdgzqMdt63kC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzxWmu/b; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzxWmu/b"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so14972495e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049818; x=1789654618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZNv1IJHXjclUxxs9te9sqmzRhOxAa9ASWy+fWccWYN4=;
        b=gzxWmu/bwG7kMmhfPbwGcJVHzzupA/7iTAJIfVa2xLu11niHy2pEnDrCxxUeN9JOMB
         vYDd2jMfzCYv1sTvsle4+D4rRRq4DnOv6PrM2iO25Yh4amp6ZsRxxt4Jz5PSoKcisqmp
         jBsYnMuO0NFa/MNaIsRZhMR1V46RdIv2/i2Pl6yd6rtpWZ+iCnS3Mr2UrNtNJF32wYkr
         VtWGfsDVEuGurmtzKyVebwJ6YF+obp89tJ8KBcaDBX4Gp1ixkZBtNN4BphUlN6jhOG2L
         P8qasAhxCIsJsHNLFdZunbFaduagVFH9OWB26QggwmjtsyTCOJzuP/hCbknXgyyPjbm5
         QfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049818; x=1789654618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNv1IJHXjclUxxs9te9sqmzRhOxAa9ASWy+fWccWYN4=;
        b=b/L+/G+8a0QMoby3mTzXKdhLeSccN/oRy082s/XR3K4R+ADwuI9NXtkkHcIhj/0prp
         k6288ypkRUV/kHgea/7rv3JqGvvhmTITSt+cVlSq4LfSjICb6P1Q3JM6RJxxyeCY24eF
         9Eyj4uXC3BNjN0bEj+InZlLYfu+oQ8WZRqIZ6MgRH8J9ehXhy9qQ/0/PeDi9qtXmPNSw
         kZdgJzrm0qRs6zA4TKgUS1XW/hdHEG32+CkQVjQZ7D+zuDDnvEECio8bIDSEPBmWTVUM
         CCxRIvS5C3VNzAv8yTjUZVHl5SFQPZKGTuLiOmByb/nU7R6oeAzQCBqNeswl+WlVI10d
         Bh0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/C3/qoZaw/f6jkacOH+LC5w9YsTKLpz5f//A/Zct1qQEmV3vmF3yk5RomlgcugJ59xiCTZRxym5I=@vger.kernel.org
X-Gm-Message-State: AFuF++lZF43Acs3300ucSGU5AHWYY6t6eZ5MIA9o+9ch52UmqaUjgX8U
	TJGOBwnEynJYwIjyhQS2TOmtFAcgg+513GbNFmh5g88GamzOJIe+iaHk
X-Gm-Gg: AYBFou2Mxj35yjhd+bzR52LlYTJSqhDhxK5wMmwEFHQWn50kn/ppyaTG6vlD1AgYRbZ
	rGfbvdtwYcxUoUaEiqIVrCKn0KD9FoT1/0ae2y/amHjM9JfSjX3SVsjufwcegHG7MB05lxff0KX
	S0KOugknG72KODHGP+p74xXbm8F8T49K0rOkaB+FAnFHCENkzO+oJpl1qG21IVfIjnaIombGbcT
	KQTHk+rz78ew4eVfpTNwWoNWJz5avn3ljMJKmMtlNskZdIbSn5aNqNEat1sY5gSXereVhXfVwXi
	RJFXtikWptyRf3w5TdVjeetjZ9xPByZ6BI0fQIVNCOt0PVaqsuhHGebru0K9YORLnZ/H4Svrq+j
	lo40YZFGAQwOE9cdQRvH0X8PYyS6DZa8HcxrgKAQpTYO+zNF8CgQo+rUOChgRyf65V9UE5Rl63/
	eLLOrDJ2axoL8uew/F4KRLmZJ1mxoru3WPO0m3ZVYHWhOqRBkHza/pgsSMZFlaI0YicdvxPMgET
	V+lfswfUvRx0xHkZDbLx4/0HFrMzxpxJvse/58JaSxiKicHR0P53yyZ9jCBc/7m8P+XGAsQQA==
X-Received: by 2002:a05:600c:4712:b0:49d:2705:7030 with SMTP id 5b1f17b1804b1-49d270571ecmr49038005e9.7.1789049818180;
        Thu, 10 Sep 2026 07:16:58 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm293895575e9.4.2026.09.10.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:16:57 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 10 Sep 2026 16:16:48 +0200
Subject: [PATCH v2 7/7] of: unittest: Test fw_devlink with clock nexus maps
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-fw-devlink-nexus-ready-v2-7-17ac82dbe226@toradex.com>
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
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Extend the fw_devlink OF unit tests with clock references routed through
a nexus map. Verify that the mapped consumer has exactly one link to the
final clock provider rather than to the nexus.

Also cover a direct clock reference to ensure that it continues to
resolve to the original provider when no map is present.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/unittest-data/tests-phandle.dtsi | 14 ++++++++++++++
 drivers/of/unittest.c                       |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index eef966615b22..aaf0b871c01d 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -81,6 +81,10 @@ consumer-b {
 			};
 
 			fw-devlink-tests {
+				clock_provider: clock-controller {
+					#clock-cells = <1>;
+				};
+
 				gpio_provider: gpio-controller {
 					#gpio-cells = <2>;
 				};
@@ -90,8 +94,10 @@ pwm_provider: pwm-controller {
 				};
 
 				fwdevlink_nexus: nexus {
+					#clock-cells = <1>;
 					#gpio-cells = <2>;
 					#pwm-cells = <2>;
+					clock-map = <0 &clock_provider 1>;
 					gpio-map = <0 0 &gpio_provider 1 0>;
 					gpio-map-mask = <0xffffffff 0>;
 					gpio-map-pass-thru = <0 0xffffffff>;
@@ -100,6 +106,14 @@ fwdevlink_nexus: nexus {
 					pwm-map-pass-thru = <0 0xffffffff>;
 				};
 
+				clock-consumer {
+					clocks = <&fwdevlink_nexus 0>;
+				};
+
+				clock-direct-consumer {
+					clocks = <&clock_provider 1>;
+				};
+
 				gpio-compat-consumer {
 					gpios = <&fwdevlink_nexus 0 0>;
 				};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index b739a69997a9..2859a44c3fe5 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -765,6 +765,8 @@ static void __init of_unittest_fw_devlink(void)
 		const char *consumer;
 		const char *supplier;
 	} cases[] = {
+		{ "clock-consumer", "clock-controller" },
+		{ "clock-direct-consumer", "clock-controller" },
 		{ "gpio-compat-consumer", "gpio-controller" },
 		{ "gpio-compat-singular-consumer", "gpio-controller" },
 		{ "gpio-consumer", "gpio-controller" },

-- 
2.43.0

