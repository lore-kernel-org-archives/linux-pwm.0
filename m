Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1422329392;
	Fri, 30 Jan 2026 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749940; cv=none; b=n+2OpuvMFNm1IcdGu16L06pbbcm87J4vewb+haKVbw+0d08WfY9+6EYX0LVjnB8759PW9U3x0T0AHN0rorazZ6epGZ6wSPWPG5jAdqe6R/2rg496Oltnwp0zb6+eJ8+v4uSH11ZjCRjew56MLEZ1+18rBezw1i6sNcz4SZ3wNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749940; c=relaxed/simple;
	bh=XRTXKmVjr3TZFfKZ/DbL+RHaFXvxsYezIPJIp/AqseA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFTgwmswhrW1U+5J6qYL8bq7xdcDPWlq5JS1k1FZw4HN733wVDev+/FlEBPK+Eri6LdbZOPxhJq9xCkGjfOCmG98OcsBFrFanDmJ51fDCXee7hWACkyuI3iulu6l88vj6oxMQPZIhXELZp9dtsEpOXXsh8N0CjnLsB9uCCzD/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTP id 60U5Bgw0021883;
	Fri, 30 Jan 2026 13:11:42 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 30 Jan 2026 13:11:42
 +0800
Date: Fri, 30 Jan 2026 13:11:41 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
Message-ID: <aXw9jY5kpPNAiyxR@swlinux02>
References: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
 <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60U5Bgw0021883

On Thu, Jan 29, 2026 at 08:19:00AM +0100, Uwe Kleine-König wrote:
> I would rewrite the commit log to:
> 
> 	pwm: Remove redundant check in pwm_ops_check()
> 
> 	ops->write_waveform is already known to be non-NULL so there is
> 	no need to check it a second time.
> 
> 	The superflous check was introduced in commit 17e40c25158f
> 	("pwm: New abstraction for PWM waveforms").
> 
> 	Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> 
> to make the change more clear and also to not bother the stable team
> with backporting the commit to stable.
> 
> Please confirm if you're ok with this change, then I cope for the update
> while applying your change.
> 
> Best regards
> Uwe

Hi Uwe,

I'm ok with the change, and thank you for the review.

Best regards,
Ben

