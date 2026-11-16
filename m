Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798648;
	b=RDUUH/psC1fNuxn/fMwccZTaVMIfRvu7JCfvMe1eI3UmO8j+P0f4eTT9TFMAYYnqJKt7
	 0LXJJeAtFPeQLJH1y6m6VAiT91ICWsFh9JRcHC+Dg6dMiOnHtBwHBrCdRyW2UE95sL8V2
	 +J6ej1UckfEHCGHz4m26HNXUSGXluKmYsrmfI4oZgNPkn+7eX1gM9nKpRsRknu/9Li115
	 DIlvaeIdmjTbFZHK+J9Pi0QY6vF27Pn7XZTmP48PK/wriZHjREeX8thO+Pbmo8RcthadX
	 DxwtdfSpP+ChFuKzm7N+fOPZzsAYtkj9qS4d8eTEtIjUcv7mEzpSVPpS0vU5qqH6Phg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798648;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/hrvyEM6Ru8j2MY7/K4Y0eZLUVmPIavguQMTvmC9co0=;
	b=ZH+C4ynReZJZGhAr9evE0hG6xd1K4ko+mm8v5uiEcrNTDu3v9lbmeBq1fgQ8M7rjPnJi
	 UqsSb8Wu3fSX/MGfe+NPhi9sdT/VfrVS2QeyYftz76sgjCHkEk+B1BvupgCUkuj29MI5Y
	 SUf8xvpcGgi84d5ayAjQaQkpk6pyYhPi+DtyntmgedXSwZb+Wvam5S34wgDuEuerbbFJ3
	 /VmkKbddTacoZSMPpZPqsz86G8jLx+lmubVsoTv6R5GG6DP3M4d1VZU4w/zhQPXxv9XEj
	 ZDAuliH24OYH65FY3crRdT19VyzcuWu4XFgZ82Ha6zWBJ5Lhezp7Tx3PhxcvhonEZrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=buq+J3hA;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BA606A336;
	Mon, 16 Nov 2026 03:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E58BA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=buq+J3hA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=buq+J3hAwQnfDFduZU2G+tJsRWL/xW1+4sTFrayeIq3ylj1e76vdCGcSFUqYKJWFW+t07pva6Tg7b
	 bFtwX++Yd+V3pFN2ACKsY08namg/HHNVG/kPqtHGC9dBPZKMx+NTkpnVxFPsyxR78pQ79IBaQ5Jq6m
	 o8ukkNCRqGqzs6sw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afa7434a66-9aee5;
	Mon, 16 Nov 2026 11:10:45 +0800 (CST)
X-RM-TRANSID:2ee86afa7434a66-9aee5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16afa74334a2-7a403;
	Mon, 16 Nov 2026 11:10:44 +0800 (CST)
X-RM-TRANSID:2ee16afa74334a2-7a403
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: ukleinek@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: mxs: Disable clock on invalid period error path
Date: Mon, 16 Nov 2026 11:10:43 +0800
Message-ID: <20261116031043.508-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261102105005.1007-1-laixiangwu@cmss.chinamobile.com>
References: <20261102105005.1007-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I've noticed that Lee Jones' series "pwm: Fix various bugs
reported by Sashiko" also fixes the clock leak addressed by my
patch below, with a broader scope:

  [PATCH 2/8] pwm: mxs: Return early when disabling and fix error-path clock leak
  https://lore.kernel.org/all/20261105143847.2559586-3-lee@kernel.org/

Besides balancing clk_prepare_enable() on the same -EINVAL error
path, that patch also handles the !state->enabled case upfront,
avoiding a division by zero when state->period is zero, and it
already carries a Reviewed-by from Frank Li.

My patch for reference:

  pwm: mxs: Disable clock on invalid period error path
  https://lore.kernel.org/all/20261102105005.1007-1-laixiangwu@cmss.chinamobile.com/

Please feel free to drop my patch in favour of Lee's more complete
fix; there is no need to keep both.

Best regards,
Xiangwu Lai


