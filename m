Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4078544D57;
	Tue, 22 Sep 2026 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081402; cv=none; b=iVoRNxSMSS2O+QBUpA3aPFjeo3w81EggNAOE7sIu/4nZiJr8SwzuxPFf3MKUARFGJoflwKWrUZt51wKEKx+4BVEqg4diUoKgq3g6m/NfJOGo+KXSEN2PCiYBM5SRo6jP7Lw2iqNgYU2dqmVn2AJcaS0PGg1x5y5ls0AxHRR5gGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081402; c=relaxed/simple;
	bh=U61nrlf6Rzr9P45390+WWOxofv7eccqWssOJ/x8m2JQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MXnZ++w7UfuhnC1PNeODz6GNy5K6v0fR9axsbhoAi+4jVUU8x6mx3eLQ/pfgw/OlOG7BALYR3Bi95yHo36l/kuCPNEjCJKTCpsVn7Ug0P2yv1s1NzAO7cWJcS0NexsAfa1FHVgpZP/RTZCvbg7cVtHcp3Ar36oaKcqC6Lo4LMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5rLmd5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5rLmd5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C31F000FF;
	Tue, 22 Sep 2026 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081400;
	bh=zA+GCqss1BJt2eyEGaNbn9BPABpPtcuxg8nHLoRtwIY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=b5rLmd5bWxK5MhXoiYJT/vrxWKDUIQG9wU9NmlecSLJNiy50dmDpiP5HQ1qCkFAbO
	 xahaUPwLJ3+jghJTj8Lcw5eZxlEiZB9Cvbj0PbaadZGfIm6HL5HnYyxG+YC15KIwEI
	 5A3vNKw6c+9dq2c8rz1exSDfK9GFqCSktwrHOeBmXlqnA6JU1spy6CEk++lkSbzNtX
	 Z1/7CQaOJLt5tKp8PSyY2GLQfl3d1uTPPuEhNs2TeKgGX8sM7SXrPE4hSCLYS446ki
	 VghH/5KIkvUoO5tvWFskqHTHGghkqobAgr5boT72RCG6PeC3SMAsnleQYvRYQvjI+y
	 /2TCAUes5w0Jg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 14:49:56 +0200
Message-Id: <DLLUW8UZUU4G.3FX7WHWGVM1T4@kernel.org>
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Cc: "Thierry Reding" <thierry.reding@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Jonathan Hunter" <jonathanh@nvidia.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>, "Thierry
 Reding" <treding@nvidia.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
 <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
 <2026092227-marbling-untying-c1df@gregkh>
In-Reply-To: <2026092227-marbling-untying-c1df@gregkh>

On Tue Sep 22, 2026 at 2:13 PM CEST, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 01:38:28PM +0200, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
> What's wrong with just not allowing bind/unbind at all?  Why would you
> want that, but NOT the driver_override file?

pwm-tegra is a platform driver, but for drivers on hot-pluggable buses we s=
till
want bind/unbind for testing, even if we opt-out from driver_override.

Besides that, I think that even for buses that do not have hotplug, there a=
re
cases where it can be useful to be able test whether a driver survives
bind/unbind (i.e. follows the device driver lifecycle rules). E.g. because =
the
same IP will later receive an implementation on a hot-pluggable bus that sh=
ares
driver code, or just to validate driver design in general.
