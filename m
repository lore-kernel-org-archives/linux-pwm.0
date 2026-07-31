Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E947CA9E;
	Fri, 31 Jul 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526178; cv=none; b=liBRHJ0UQeFoyUOjv5hapb+7+/eZ1eRn9jG7lX2B5XKXeQ+5bDXGonDkwjWEPT0YqiqkiRRJQYpAV6ot6BJu4/WN+wsi/kQPs08PVjVjDcKw3E92YKokDIKZBvW+XnbaXJHCD9cLLDI9z863ar//3h07iajtclC9cyF+ZoMjbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526178; c=relaxed/simple;
	bh=TFmeCZ/dCUMhaw5MZ56hsGkZXQjACI0WS0CBpsOJ840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYxUurnnpWG1hdlBBhz7YdVx6cRbKlQ+na94bOwsbo/iyJkwgsiv+DVo6WkZRHlXir0sGCJu1ADa/bLqtdUpexlg7u4J2PjvlFgz+TMOKvKw3QBF06MqkeutccEOlUiAJ8+5/q9TGzubBjjwJOQwHVY3pn39xM48mVWTx2AuPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giwc9ViN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giwc9ViN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785526176; x=1817062176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFmeCZ/dCUMhaw5MZ56hsGkZXQjACI0WS0CBpsOJ840=;
  b=giwc9ViNpUDm+aG7vw7Qv2YdG5TRmyCEMCpapGSNQ5FD2tEz+Z+EoQzg
   +oi8V61KNKbcV3qDvJN1HM0JOpW5DUtWIFDZ7VigDqTBUvld/khWXmSUT
   Obf38ibAUyK07UN3GXMCVjf8MktrT6SSyJEpN5LF2rYPBj47BKvGbnwnN
   GbkAS0wn7BxvO5dQ2rPvp63XRXSR6KhTMsak2A2DyASCstfZffM2qrcfv
   78gSDb4GTETVNyN3Mmp5vMm/GvkvCUhemKoJbL8jZFkTzy1AkWoMoWMVf
   Ex46gVI6ZLNvISHx4s5T8ylbqJA8wjxvfJfxMcmL4gVvh+oEHPasbg7Aj
   w==;
X-CSE-ConnectionGUID: rkeiqQJ/T++48tFuvyuiYw==
X-CSE-MsgGUID: Pmw6N5UiRYexWu4MIB4vug==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="90042765"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="90042765"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 12:29:35 -0700
X-CSE-ConnectionGUID: qnGitLgpRJ20PIJsLXOqrA==
X-CSE-MsgGUID: C1mGXY86SZevA5mPOhN5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="254358296"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Jul 2026 12:29:33 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpsvB-0000000024j-3GQG;
	Fri, 31 Jul 2026 19:29:29 +0000
Date: Sat, 1 Aug 2026 03:29:20 +0800
From: kernel test robot <lkp@intel.com>
To: Stephane Lepain <stephanelepain@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pwm@vger.kernel.org, Kenneth Kasilag <kenneth@kasilag.me>,
	George Moussalem <george.moussalem@outlook.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Baruch Siach <baruch.siach@siklu.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Lepain <stephanelepain@gmail.com>
Subject: Re: [PATCH] pwm: ipq: fix period calculation
Message-ID: <202608010336.m82kvZZ8-lkp@intel.com>
References: <20260731070542.155398-1-stephanelepain@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731070542.155398-1-stephanelepain@gmail.com>

Hi Stephane,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.2-rc5 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephane-Lepain/pwm-ipq-fix-period-calculation/20260731-152907
base:   linus/master
patch link:    https://lore.kernel.org/r/20260731070542.155398-1-stephanelepain%40gmail.com
patch subject: [PATCH] pwm: ipq: fix period calculation
config: arm-randconfig-004-20260731 (https://download.01.org/0day-ci/archive/20260801/202608010336.m82kvZZ8-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project bacfe2950f8218268fcc0a8765644ea0c15f0360)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260801/202608010336.m82kvZZ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608010336.m82kvZZ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-ipq.c:123:25: warning: result of comparison of constant 16000000000 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
     123 |         if (ipq_chip->clk_rate > 16ULL * GIGA)
         |             ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
   1 warning generated.


vim +123 drivers/pwm/pwm-ipq.c

    87	
    88	static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    89				 const struct pwm_state *state)
    90	{
    91		struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
    92		unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
    93		u64 period_ns, duty_ns, period_rate, min_diff;
    94		unsigned long val = 0;
    95		u64 hi_dur;
    96	
    97		if (!state->enabled) {
    98			/* clear IPQ_PWM_REG1_ENABLE */
    99			ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, IPQ_PWM_REG1_UPDATE);
   100			return 0;
   101		}
   102	
   103		if (state->polarity != PWM_POLARITY_NORMAL)
   104			return -EINVAL;
   105	
   106		/*
   107		 * Check the upper and lower bounds for the period as per
   108		 * hardware limits
   109		 */
   110		if (state->period < IPQ_PWM_MIN_PERIOD_NS)
   111			return -ERANGE;
   112		period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
   113		duty_ns = min(state->duty_cycle, period_ns);
   114	
   115		/*
   116		 * The period spans (pre_div + 1) * (pwm_div + 1) input clocks. Rather
   117		 * than fixing pwm_div at its maximum (which gives usable duty
   118		 * resolution only for long periods and collapses to ~0% for short
   119		 * periods) search for the (pre_div, pwm_div) split whose period best
   120		 * approximates the request while leaving pwm_div large enough to
   121		 * resolve the duty cycle.
   122		 */
 > 123		if (ipq_chip->clk_rate > 16ULL * GIGA)
   124			return -EINVAL;
   125		period_rate = period_ns * ipq_chip->clk_rate;
   126	
   127		best_pre_div = IPQ_PWM_MAX_DIV;
   128		best_pwm_div = IPQ_PWM_MAX_DIV;
   129		min_diff = period_rate;
   130	
   131		/*
   132		 * Smaller pre_div than this cannot represent the period (pwm_div would
   133		 * have to exceed its field), so start the search there.
   134		 */
   135		pre_div = div64_u64(period_rate,
   136				    (u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
   137	
   138		for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
   139			u64 remainder;
   140	
   141			pwm_div = div64_u64_rem(period_rate,
   142						(u64)NSEC_PER_SEC * (pre_div + 1),
   143						&remainder);
   144			/* pwm_div is unsigned; the swap check below catches underflow */
   145			pwm_div--;
   146	
   147			/*
   148			 * Swapping pre_div and pwm_div yields the same period but a
   149			 * larger pwm_div gives finer duty resolution, so once pre_div
   150			 * exceeds pwm_div every further candidate is strictly worse.
   151			 */
   152			if (pre_div > pwm_div)
   153				break;
   154	
   155			/* need room for 100% duty, where hi_dur == pwm_div + 1 */
   156			if (pwm_div > IPQ_PWM_MAX_DIV - 1)
   157				continue;
   158	
   159			if (remainder < min_diff) {
   160				best_pre_div = pre_div;
   161				best_pwm_div = pwm_div;
   162				min_diff = remainder;
   163	
   164				if (min_diff == 0)
   165					break;
   166			}
   167		}
   168	
   169		pre_div = best_pre_div;
   170		pwm_div = best_pwm_div;
   171	
   172		/*
   173		 * If the search found no usable candidate, best_pwm_div is left at
   174		 * IPQ_PWM_MAX_DIV; cap it so pwm_div + 1 still fits the 16-bit field
   175		 * and 100% duty remains expressible.
   176		 */
   177		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
   178			pwm_div = IPQ_PWM_MAX_DIV - 1;
   179	
   180		/*
   181		 * high duration = duty_ratio * (pwm_div + 1)
   182		 *              = duty_ns * clk_rate / ((pre_div + 1) * NSEC_PER_SEC)
   183		 *
   184		 * Round to nearest to avoid biasing every duty cycle low, then clamp
   185		 * to (pwm_div + 1): rounding or a 100% duty request can otherwise push
   186		 * hi_dur past the period length and overflow the 16-bit HI_DURATION field
   187		 * (which would alias a full-on request down to a near-zero high time)
   188		 * and asking the hardware to stay high beyond one period. pwm_div is
   189		 * at most IPQ_PWM_MAX_DIV - 1, so pwm_div + 1 always fits the field.
   190		 */
   191		hi_dur = DIV64_U64_ROUND_CLOSEST(duty_ns * ipq_chip->clk_rate,
   192						 (u64)(pre_div + 1) * NSEC_PER_SEC);
   193		if (hi_dur > (u64)pwm_div + 1)
   194			hi_dur = (u64)pwm_div + 1;
   195	
   196		val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
   197			FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
   198		ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
   199	
   200		val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
   201		ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
   202	
   203		/* PWM enable toggle needs a separate write to REG1 */
   204		val |= IPQ_PWM_REG1_UPDATE | IPQ_PWM_REG1_ENABLE;
   205		ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
   206	
   207		return 0;
   208	}
   209	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
