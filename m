Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061F199BE;
	Wed, 14 Feb 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907289; cv=none; b=uy/Gd9Lx24hydI6Vvv9Ctc52NZB+UnVkhoCuPlReWbIdKFhUNq3vob7xkcAVTOLCkhtv/XllfHXOqYhmtbI0qPt7zkCZZKaaXcbr5d1zmYJUDMWMtRkeloNX/siWhDCOf52yeP9flTnH8e5r0roHnkr8riM66Nb6zzlSrJQmluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907289; c=relaxed/simple;
	bh=Di6XWze6g+2Ydl1OpMLyZmGD3JYXr0quXiZRJEZicH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URJU4UMF8ygopM7grX3nsglbZhmBLxbIrEUKCSDjvFSZi8NRKDVD9pDAKOB6SeNtdkpA4WUypQcL5sVSksY3s951wpjt/Hi4xeSFpcEHDqtEgEW7fthtb8aHSGCIQd9gHQGx9tFyvUC+jGd7rfQJi9KamNY0BKwkzfknvnLMWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8vBW7pZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8vBW7pZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ACAC433F1;
	Wed, 14 Feb 2024 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907289;
	bh=Di6XWze6g+2Ydl1OpMLyZmGD3JYXr0quXiZRJEZicH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8vBW7pZyn/mOm2jtgtUPJNOnjQOBNNBmdrhHRtRhm5gLCYL008wGQ0rGen+JgAiI
	 Fv1UKNKTlTpWWn70O/G2MWk4HvU4jrrsOGJdwoRhD7/JwjR75Zx4VkjHG3n24mhy3M
	 8B1BgtYmpeaeoz9mLQ9xvcr46vsE1JOoqsCtv37Q=
Date: Wed, 14 Feb 2024 11:41:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 160/164] staging: greybus: pwm: Make use of
 devm_pwmchip_alloc() function
Message-ID: <2024021418-acid-scalding-9fcf@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <3206ab7f49c2c1704ea69446f3b7a7d1e71200fa.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3206ab7f49c2c1704ea69446f3b7a7d1e71200fa.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:27AM +0100, Uwe Kleine-König wrote:
> This prepares the greybus pwm driver to further changes of the pwm core
> outlined in the commit introducing pwmchip_alloc(). There is no intended
> semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
