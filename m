Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11420542ED1;
	Tue, 22 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079539; cv=none; b=ZT702/dlu0O9eSv6jZ6HeqotPs+ZVLyZUQeY0MHs3rsUkBPKOEH/Ax39V6IBIIWg7E4kSNZaLN8jRWkhRhQRo1lPLSYZXh6tzKBzRWjDRyAhNBek52y3cXb4GvhJzQFheb9BiEGegNuorCH7xF0CAyocDTeyjIwXpZbTH1YuRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079539; c=relaxed/simple;
	bh=l5RZcKg+LbYgBEC38tBWMYTL90wiPcpCp/KCZSxeShI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ8lmrf5C2QlOGLaSJxIzTEgDx1p8LpM8Rxy8sQBz3hxW2Ylx8LqZW56ZEe3fbuNFaLCAeBBDrtY6586QVN2VsHAYy0/ZiUGl3GF5buHZNpznLJBQ4GGd3bj8Hosg/qFLamMb6WZUQbfH12HJw34v3Fy7yudrH+NB/b+6ph7UPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HqFu3q/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HqFu3q/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFE51F000FF;
	Tue, 22 Sep 2026 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790079538;
	bh=2CErJxI8kyBH6yMs3SPQRJ1NFZT9+yN4VflkNoKBvRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HqFu3q/pviOh3Oc6Q8MqNEDMW/AVtEW5lj6PEBuc9jg3zmaDBK+B/gh1SQspCGgBQ
	 ggBEwxbrvfcsrXbfn6vmXjVSsOI9VK5lq0W6Fv/uKRIa1dPppbujzfHpDFh3vuejmG
	 aaExi+2JBCoFx32lljQzNZVb8eghX74k7pM4wLL4=
Date: Tue, 22 Sep 2026 14:13:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Message-ID: <2026092227-marbling-untying-c1df@gregkh>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
 <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>

On Tue, Sep 22, 2026 at 01:38:28PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Some drivers rely on device data obtained through device ID matching and
> will not work otherwise. Some such drivers don't check for the validity
> of the device data because it is never NULL when the device is matched
> against the device ID table.
> 
> However, Uwe recently pointed out that drivers always need to check this
> device data because any device can be forced to bind against a driver if
> their driver_override sysfs attribute is set and the driver rebound. Any
> such device will now not have device data from a device ID match table
> and may crash.
> 
> Add a flag that allows drivers to opt out of the override mechanism when
> it doesn't make sense. This allows us to deal with these situations in
> the core rather than sprinkle checks throughout all of these drivers to
> check for validity of the device data.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/device.h        | 12 +++++++++---
>  include/linux/device/driver.h | 12 ++++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 90cdd77458bb..45c23cc5efa8 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -899,14 +899,20 @@ static inline bool device_has_driver_override(struct device *dev)
>   *
>   * Returns > 0 if a driver override is set and matches the given driver, 0 if a
>   * driver override is set but does not match, or < 0 if a driver override is not
> - * set at all.
> + * set at all or the driver opts out of the override mechanism.

What's wrong with just not allowing bind/unbind at all?  Why would you
want that, but NOT the driver_override file?

thanks,

greg k-h
