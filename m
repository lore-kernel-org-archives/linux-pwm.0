Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04F3D9054;
	Tue, 21 Apr 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783655; cv=none; b=GSh+24Opmt5p8Ur0xqy57J9BKG1JNT5Ps2XhMHK8ZxG+5a1Dt6XrqDkIrqQ6buSPVGugq88Zy5WOb5BHidszsH4cufQ9BKEptre1THqFV5J3HXp6Ly0nm2hMtqqaPa4daH/Cuhfo0UgRF3OktPOTIYSJjnBnYCdg/+k7ohahgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783655; c=relaxed/simple;
	bh=M1c/B+5umROsW5JwL12llykfEuZvqDK7wXMrS3mbS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXKWlUMRv0il5b4czLtVgy75cimVO1jr/NSfpUkjvuq5CIQSiHK+EsDdM6KvE46ZIfigFfiCiDc0V1mcvbd9VDQjjsNvLAzn//YvCEjJ2nnDfHWgSJROktlFfnZ6KNvV8ywWlKzuBAz6SOdoagiynFBYEOhOaPdf2SkqZjdycKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2Gy+FrQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2Gy+FrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776783654; x=1808319654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M1c/B+5umROsW5JwL12llykfEuZvqDK7wXMrS3mbS0E=;
  b=R2Gy+FrQoRm2n6WsvryzTPmAfqSYVveUam1ZhAY6yhTwED5X6oJqUoYQ
   sG2xCanRWXcfNdxgj7Z7WVHlrOahl1A/qN184EfC2EDPXdu+RckW1td92
   oW3fLA0mwuyziCFFwOPwo2EpkLuDD58z754avv6rJb8QZ/t/RSW8xp7Z4
   juwu6Rx/elAz9gqukaLGwmuSpNxtB6nAg8HHkuZQFj78p8uGeDCeJFCBB
   I1MaSuH+ygYxkE4ug30/Zx4U3vO1V7Gt+nDd84v6fwj2pg+VgSkpmMKeE
   V01q3GUXr+yxGe9Gs5Q9NL4HU9H75kikV5Bm9zAr9OZky15d8QDxhZ9qu
   A==;
X-CSE-ConnectionGUID: CPqZb6nBTVSumL6lievz1g==
X-CSE-MsgGUID: PW7k7g3QQh2IvvzM7TiOCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76881150"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="76881150"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:00:52 -0700
X-CSE-ConnectionGUID: pbRUFtS+SDmvOGqd0UCS6Q==
X-CSE-MsgGUID: vpRr+DXIQvCP3qjNuJZ6iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="237041238"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:00:50 -0700
Date: Tue, 21 Apr 2026 18:00:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Message-ID: <aeeRIJEToTZFa1Cg@ashevche-desk.local>
References: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
 <ab3GbpMDeH9RbVOm@ashevche-desk.local>
 <aeX3oUzDqWSOTTsN@ashevche-desk.local>
 <aedJDX0ONKhgTD1k@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedJDX0ONKhgTD1k@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 12:03:07PM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 20, 2026 at 12:53:37PM +0300, Andy Shevchenko wrote:
> > On Sat, Mar 21, 2026 at 12:13:06AM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 20, 2026 at 11:07:55PM +0100, Andy Shevchenko wrote:
> > > > This driver includes the legacy header <linux/gpio.h> but does
> > > > not use any symbols from it. Drop the inclusion.
> > > 
> > > Sorry, this is just a 1:1 copy of the previous message sent by a mistake.
> > > Use whatever you want, though, they are absolutely identical (body wise).
> > 
> > Uwe, can this be applied?
> 
> No it cannot:
> 
> 	$ git checkout pwm/for-next
> 	...
> 
> 	$ b4 am ...
> 
> 	$ git am ./20260320_andriy_shevchenko_pwm_jz4740_drop_unused_include.mbx
> 	Applying: pwm: jz4740: Drop unused include
> 	error: patch failed: drivers/pwm/pwm-jz4740.c:10
> 	error: drivers/pwm/pwm-jz4740.c: patch does not apply
> 	Patch failed at 0001 pwm: jz4740: Drop unused include
> 	hint: Use 'git am --show-current-patch=diff' to see the failed patch
> 	hint: When you have resolved this problem, run "git am --continue".
> 	hint: If you prefer to skip this patch, run "git am --skip" instead.
> 	hint: To restore the original branch and stop patching, run "git am --abort".
> 	hint: Disable this message with "git config advice.mergeConflict false"
> 
> That is because I applied the patch from the other thread :-D
> It's commit 8ab1fc910415 ("pwm: jz4740: Drop unused include") and
> already landed in Linus' tree.

I see, thanks for pointing this out, seems like an outdated email in my pending
mailbox. And thanks for applying that!

-- 
With Best Regards,
Andy Shevchenko


