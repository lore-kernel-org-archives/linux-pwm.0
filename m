Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99893358A7;
	Fri, 20 Mar 2026 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044788; cv=none; b=h0NmsK0iYJ5d42vVipkEGoZn2qwG0DozYBDuEDXOG1eHTmBwsVu6H5iLwonZNWWFVqChF8YIkOfhipeLeS0ZaCJBe8WfBPHAeLFmyqRmzSkpeE6lcjIdvkafxTT/BiKoHkOWsfRSOjfKBv22ioyvDPsi1+XWMy/2afUyhLzTp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044788; c=relaxed/simple;
	bh=A6MkdyvDaD6dZ/rH3UH6T/tANNR86Q9uwddVj7KlJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOOeH2q8Jj8bKF0GROMu7/5g3SBFgPSTW00PIpV3wNEQ6XryG7ji7K1y8ajy0J3iWH6Daqt7WLXVZYbwkK34SkM51K7x0BuKHGsatB8YBnhZQ9SK9ecMKrA9jr9sT8XFQxS02xXAt5INBS4CvRJQ+zwJUpga4E6+vUhYqazzcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtwgtw+B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtwgtw+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044787; x=1805580787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6MkdyvDaD6dZ/rH3UH6T/tANNR86Q9uwddVj7KlJ1g=;
  b=dtwgtw+BqIrSkC/O8ZjakaqFPvL4mLyMr0rzNzMiU2k64doQZf8IyePE
   ha3/aGCeAgUzpeDPujP8XY3vLq8MdLgH643/K1FxkhqtXPW/7I9Zysr+X
   nZ0oOEymzlfKo9+f1Kuxytsnleg03j3ZXa/054b2comzVNXcde14u8ItP
   biOWmaGz2hTL0vSekyGgWvkedgGENesgAPBeK3KIi7FLYx0B96o+nPtDk
   rfVazEgsqMhrPXsJX+2aSEIlwgcIlAJGJi7CTWlbvvdmAdKqOrzsZl2IO
   Kn9bthcd+9ydP4JI8gDxw1plmxA7FscTemAuZHeVmkdMx9KgzZNANz5wb
   w==;
X-CSE-ConnectionGUID: dvcTDSwFSQOKkZUG54h7Xw==
X-CSE-MsgGUID: t2YxCGv9RvW+987f8j2JTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74153631"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="74153631"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:13:06 -0700
X-CSE-ConnectionGUID: AEhFQDCOTnqhy2EfcA5pmw==
X-CSE-MsgGUID: ujf6mYgXTNK5PW+TKwnvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="222638791"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:13:04 -0700
Date: Sat, 21 Mar 2026 00:13:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Message-ID: <ab3GbpMDeH9RbVOm@ashevche-desk.local>
References: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 11:07:55PM +0100, Andy Shevchenko wrote:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.

Sorry, this is just a 1:1 copy of the previous message sent by a mistake.
Use whatever you want, though, they are absolutely identical (body wise).

-- 
With Best Regards,
Andy Shevchenko


