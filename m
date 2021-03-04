Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527DDC433E0
	for <linux-pwm@archiver.kernel.org>; Thu,  4 Mar 2021 02:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4C64DDA
	for <linux-pwm@archiver.kernel.org>; Thu,  4 Mar 2021 02:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhCDCoN (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhCDCny (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Mar 2021 21:43:54 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260FC061756
        for <linux-pwm@vger.kernel.org>; Wed,  3 Mar 2021 18:43:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 2so10267617qtw.1
        for <linux-pwm@vger.kernel.org>; Wed, 03 Mar 2021 18:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2rQ/+qfqDHNMsOFwnT814eTwP+Vh04AEIGtU1NncxE=;
        b=H/JaHEqj2kT5FTBZkMWtLShWL7EFGhlqYVJUSobNY6MMaPX7+BCGVHeAsMDpI5q8ZC
         t8AtvI9o/rxHfiTApqHvqMI8t95LeIRp4jUEg6Xh3TUUSNfQIP+6zdBn62r5hRk1W/CE
         hXA3vbrkbuDzuNeX2ZPRtnpPAX2yGoh+RIWMwJsYv1PojmhGOWKpa+Jxnhb1kQweUltI
         8jKrgRj3HHzIvFiAbgfCQ7u5xRMhM2FsgkMj5sw3dyXd9i+s+YzxKYIEMhiMPEKgU4z+
         NDJS6wo9sOZPK1tNJ78Nr9C+GY2RFVSPEXnpQR81+GuWtPxnksEfXskkJUCId5rcFO+u
         fRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2rQ/+qfqDHNMsOFwnT814eTwP+Vh04AEIGtU1NncxE=;
        b=DstEqy6KR8ogaYZKlK4KFM0bot0UBmZ2PVr1ZE5JibEVlWDNspxCgnfnfBs6zA5SEc
         BRqoEm3uuGX2Akq2mwkdhLz0TeCsWAo8Vdi8hRDUYnGAKB6O1xg3PWXQnyEO1aTxSohQ
         Xtl7eRV4ZG5+Ttz0I6M/drmAgiBYZjXUIRc4KcfX+icyNM2bBV6NoXfAPxs2h527xFH/
         xk3qtLgHFR1DMoRRFOxBWQeY8KKACrfSeCkeVKD0/mGgA4Qla62MD+CUjRC/WmN6dk4N
         wpf8Y0HoFeuq9Cs+01eurWyDBgAXvGqy+cXRFf1FyG6lhQ3YfAwTmwL0YtSkDANslOPk
         OYJA==
X-Gm-Message-State: AOAM533UqVIOqyKM1l8H+SMZnVm59a47WuSf6P/mOk/hdbX+ItPECcmb
        QouTXaHN7ZWmyEMZyp1f1L8=
X-Google-Smtp-Source: ABdhPJyMPOwphSNB0e3YM9/2fobyAeAhBTX3VMjFa7lyN8wZtBL3yd2wXAJuu/pd+3w146xTIOQsLw==
X-Received: by 2002:ac8:5ec3:: with SMTP id s3mr2239685qtx.145.1614825794015;
        Wed, 03 Mar 2021 18:43:14 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:919::1001])
        by smtp.gmail.com with ESMTPSA id x57sm14793581qtb.25.2021.03.03.18.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:43:13 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pwm: imx-tpm: Use a single line for error message
Date:   Wed,  3 Mar 2021 23:42:42 -0300
Message-Id: <20210304024242.2363294-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is no need to split the dev_err() call in three lines.

Use a single line to improve readability.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pwm/pwm-imx-tpm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index aaf629bd8c35..eec9ec4e1a2a 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -411,9 +411,7 @@ static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
 
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret)
-		dev_err(dev,
-			"failed to prepare or enable clock: %d\n",
-			ret);
+		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
 
 	return ret;
 }
-- 
2.17.1

