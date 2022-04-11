Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC56C43219
	for <linux-pwm@archiver.kernel.org>; Mon, 11 Apr 2022 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbiDKPXj (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347791AbiDKPXf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 11:23:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A543B568
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 08:21:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so23486617wrg.12
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nO+ziw2+OwYKXZ9RD5bVom+jjKT6xZaKn0PGeE1P/J8=;
        b=X10M8i6LqgkLpnirkFuFhbGWDEdgC6SKSLtESuIZawzrbGK3IDi546aieNd097BY2z
         ay+i5c19JkFEsDx2AbdtprOjDQ0AEpDVdiNfXTuAyrem2TmGeMfY1L482Da59y67A6Us
         0ti9J5oHo+26Eahn4ebySPoEQsoQR8nfqcDQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nO+ziw2+OwYKXZ9RD5bVom+jjKT6xZaKn0PGeE1P/J8=;
        b=xFRYuj0JL7mjHXFT8yo5NWIDIlSyPlutDNTZSyZUDeITHh+LzcYkh6ze7F2vX/wKpx
         JEcARfwbG6tm18SyQw7vGhg8ggDtLQEv4mUiAlkmiZM64PsS+TO1bzJTvis1ptub6FWH
         bmfQMnXj9R6xyC7LkpCwCsznEvddE1hW+nudz98XXJGw+zKUtv7TCqFgqQ1WoPHod7ck
         qKaSTV60UyOfgFU57IMqyF4fglYx4S4mjUlsGZ6hJ0Db4+xEUbhljh6Z+fA7I4y8hKuW
         zT5QsCo2h3i2Bxz522C9Y7FjRVILyVbJAYWGY/ZW67725x9WtqKWaxhY5ecBWNzBY26V
         WWxA==
X-Gm-Message-State: AOAM530loBR+FNKF6nbEozDDCKe+RfdyPNosufTSD0Ai2QrKM/XQPOpw
        zP5dJBKmDzO8MijSpmRfaTYqJdKngXPTnQ==
X-Google-Smtp-Source: ABdhPJyRgPtc/mqqSqMNepmVZKr82ZTqK/aUu8qj5by+Cy6OCHkYZF3ZdUnVzvPcFirBMDbg7iJKuw==
X-Received: by 2002:a05:6000:1848:b0:204:e92:5af6 with SMTP id c8-20020a056000184800b002040e925af6mr24963556wri.180.1649690479797;
        Mon, 11 Apr 2022 08:21:19 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm19512832wrb.63.2022.04.11.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:21:19 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v3 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Mon, 11 Apr 2022 15:21:13 +0000
Message-Id: <20220411152114.2165933-4-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update google,cros-ec-pwm node documentation to mention the
google,cros-ec-pwm-type compatible.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 7ab6912a845f..deb9e4488773 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -21,7 +21,14 @@ allOf:
 
 properties:
   compatible:
-    const: google,cros-ec-pwm
+    oneOf:
+      - description: PWM controlled using EC_PWM_TYPE_GENERIC channels.
+        items:
+        - const: google,cros-ec-pwm
+      - description: PWM controlled using CROS_EC_PWM_DT_<...> types.
+        items:
+        - const: google,cros-ec-pwm-type
+
   "#pwm-cells":
     description: The cell specifies the PWM index.
     const: 1
-- 
2.35.1.1178.g4f1659d476-goog

