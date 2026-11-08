Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121898;
	b=ky3gtM7YA97QMtiDmblrKL9Y+Wimrk2oLDY2xu0iwy7ApMPPqgi8d9vPzjxMrb7iXWNC
	 k0O3kHTGKAfSk4YuT3Y0dhdrBkNiteLuikHxuC9Yi7/uZ+1LyowcCtxcN5wXf8S5QFrFe
	 G3hR6MBiZGtpAClinO2E6oshyvLsZWILBmQKFQQsHSYtNyQ8hBFXeDv18YDPFZT4blF2t
	 YANIlr6GCta7fyfWuy6b3qV1T2tWhUglO3tYSkUpC7GCslpXkU8f7KFnHfZs23GyFffur
	 RKie0WPENHzwhyqL6MV515MHDqF83L2+t8lDAUEhWO3P01Uy4DgqvIzs7SnW2ig9YXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121898;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=iDYuxTIfsR3d9CC8XGLLj5Ql2c2FGvDrc0OombeNd1I=;
	b=NOpIquaLPS/mDZFTs2VBgSN0V4r3Sk/JvFQhYh5hSJqxjRlPzXDW3KeA90oCDBWmdjAY
	 iYYGgkxJ5dozdwl8iF8AubMnG+xr4u2fkohVRgFchXFumIndvqrDGcNdjekxAH1OV+txb
	 uYKOmeydoqlJ6aRcixDjtflMmVtPkCihXmDBCKM0yyOr8vYxfxnHfyZ3qhlVuu4RIoQpg
	 c2/xW/dA97De5LWDFsfUZyVIjzD7kdOn4cF05df4QI7HEvbwd1bgK91ONt/yBEbcdwVSQ
	 aGMm+hc4/nmjBxb1yI/G5xAaiff2A30ZjihUTkVDiyBUhNKj+2hK5iV/t593sGWo93w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40E606A321;
	Sun,  8 Nov 2026 07:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD40E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jMkc454Gdz52SGh;
	Sun, 08 Nov 2026 15:11:32 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A87BSIw021096;
	Sun, 8 Nov 2026 15:11:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 8 Nov 2026 15:11:29 +0800 (CST)
X-Zmail-TransId: 2afa6af020a135d-61a31
X-Mailer: Zmail v1.0
Message-ID: <20261108151129320DvZcvmWq81VyEepd79a-f@zte.com.cn>
Date: Sun, 8 Nov 2026 15:11:29 +0800 (CST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>
Cc: <ben.dooks@codethink.co.uk>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBwd206IGR3YzogQmFsYW5jZSB0aGUgcnVudGltZSBQTSByZWZlcmVuY2Ugd2hlbiBjb25maWd1cmluZyBmYWlscw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A87BSIw021096
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 08 Nov 2026 15:11:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF020A4.001/4jMkc454Gdz52SGh

From: Shao Mingyin <shao.mingyin@zte.com.cn>

dwc_pwm_apply() takes a runtime PM reference with pm_runtime_get_sync()
when transitioning a channel from disabled to enabled and returns the
result of __dwc_pwm_configure_timer() directly.  If that call fails (e.g.
with -ERANGE for an out-of-range duty cycle or period) the reference is
never put, so the device never reaches the suspended state again and the
usage counter keeps growing.

Put the reference when the configuration fails on the enable transition.

Fixes: 1ed2b3fca645 ("pwm: Add DesignWare PWM Controller Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
This supersedes 4/5 of the v1 series; 1/5, 2/5, 3/5 and 5/5 are unchanged.

v2:
  - point Fixes: at 1ed2b3fca645 ("pwm: Add DesignWare PWM Controller
    Driver"), which introduced the unbalanced pm_runtime_get_sync();
    721ee1884883 only moved dwc_pwm_apply() to pwm-dwc-core.c
v1: https://lore.kernel.org/all/20261107000734514kOTBjwDH_ZQx5Rq7e_WwC@zte.com.cn/

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 6dabec93a3c6..cfeefae68969 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -99,6 +99,7 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	int ret;
 
 	if (state->polarity != PWM_POLARITY_INVERSED)
 		return -EINVAL;
@@ -106,7 +107,10 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled) {
 		if (!pwm->state.enabled)
 			pm_runtime_get_sync(pwmchip_parent(chip));
-		return __dwc_pwm_configure_timer(dwc, pwm, state);
+		ret = __dwc_pwm_configure_timer(dwc, pwm, state);
+		if (ret && !pwm->state.enabled)
+			pm_runtime_put_sync(pwmchip_parent(chip));
+		return ret;
 	} else {
 		if (pwm->state.enabled) {
 			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-- 
2.47.0
