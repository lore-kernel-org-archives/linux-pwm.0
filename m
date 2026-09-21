Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF84502789
	for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017346; cv=none; b=SkIsVCDDsRaeeFhENO2Kh8H62OtLh71EU8tmdYBfhsyprdwCru64VSuTB4wBrEY7W6ToN+m8ta9f30oXe6rf+/9GVVJ72O17hVbSIYUZU3nBiV/Hx1cqnRSSjCEykFmxfpGXJvcIyWySe8w1mLte7EuEABNR3CJPEwoLdh1hF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017346; c=relaxed/simple;
	bh=Xt2My9d1ZnGzWqEb1isRLvU2Ix5KpWtA+uFdwmPk1pc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=T3GW1MAdJRpbj+PhE/qiQRDk0qyms4/TCdnIOqqsVCFRws3VDvGrrAkZlN1NVCOtyLDWs7XJldePR1UwxTaFmqxlSkkozRW35tD/C5+SbpIdnGgBKIv/tBOXoaZN+SLZRdJG5GOYWhukcEw+Nzg//t9p9qYGycm3NNWYl+eCqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com; spf=pass smtp.mailfrom=brivo.com; dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b=x7e3d25Y; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b="x7e3d25Y"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a05d236f53so1850941137.1
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790017341; x=1790622141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GFcZ8v2IrQlVXsS28/gxish2Yf7RjcBy4ak1q2e8MoU=;
        b=x7e3d25YPd75gL8HlZ1xRpCnjjWqYlhmInOSVC2ddsvhBGE5so2kUtibji2AC5t6Me
         2Sq3TVxI2i2IxpLNruy9NVxiEtQIIOk5ecev0yBJ9VKKyXSXUqB0ZgIpbdgWHV6HH35r
         JSQlDiJuJBIitTj5cfcjs9s7EoDjC5AcmRN+lJftkSStajXLg72+d8IxbAt8r/+pYTER
         GGz41jmnLSDr1Gf3OZw0dfAak+9Lew5gF2x68JAOzNEfudwd8zv3xaHG5e4S1ABlyNem
         7O1Ggnuwbjm2Cr4PDUmZz9GReBqjzyNGLXNQLSDMOBLOXzVmTdJjq6u4mfAs3xDzBr/3
         lw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790017341; x=1790622141;
        h=content-transfer-encoding:content-type:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFcZ8v2IrQlVXsS28/gxish2Yf7RjcBy4ak1q2e8MoU=;
        b=aRD2SiuJkv5KB/BPZsI40w972YBkur0kVibKzTnHsN9PwhtQXlsoF8qRhkDn8SVeph
         ss6+sH9E8rJISAcrSOIS4NSlD4MnE+0pLYZo4RsuWIGv5ikKlxLVh5SRDYmPTKTK+J/G
         Qt7spaZA2m/Iy1om7BhwstZZ5SJfX5v5yDmRsCNkHUzjE4GDC2OBYSOO/kJzjZzLKWSJ
         uYcK3ODgqcXzwTT0Z1miKrJgjvuNqugfGNZzuLGZx+QpbEdOGu/zMSj9HBVV1RzPDuTR
         ZxbWB97gBQ1So7tyPi8G5tqkhICue2USxLxnywfKXEINHyET6YpPUOfRAiW9c26eH6RL
         YEMw==
X-Forwarded-Encrypted: i=1; AKwUvByqUJdE0c/+iIAY///LSNT+IrLDykAWwT1xzRvbskp98P3IvWS6PPSXX0bV4DFaV5yl0SQIPkZNKbo=@vger.kernel.org
X-Gm-Message-State: AFuF++llzwvRMrL180lu8TdXfiCKVpweie0Djeq68XCpanng9JG5onaH
	M2/t3/pJt6A5OhaS+a+Iz8LUdgSp6xK6Lgfunxh0foZUy2k6ValU1s4FgCwjNY0UFB4oomGi4Ub
	DoSW3jSr4j8YLEVs6WzH1ngOI2r8Mtnku40VR9s/6gUtOT7LRcodDqVg=
X-Gm-Gg: AYBFou32AAnkEZddzvy6qjcxV2u2f1dOVA+1jBPj8c9qUY2KAQI2MiKh6Wt7XcAvojz
	rYoop3OPt1qPprm9mX5i9YzY202VUSy5h+LmgqZFWKIBBUW3yVpuQR4YB+W3MFvi7cNpuX4T4GJ
	5MvH3mNt5tGzx95DS4D7k5KA354gOgQn0tax0GafBiHJc5rvManf+YxHG9X5AbHPnQKnWyTvOv/
	92S2SvAjH4WP2sFoD7TDKIjOkHMN/ows3FVgfRsQ07i4sVtxH1p6f/Q2V24dGK41hwhSCxOrcLK
	v04UQu5Q5Gey6tVBoK0Kka2+G9Hdb57Q34kDYHXXUgOOrC4x8ohyXCUY1W32Y/efGXUG0zhG0Sw
	BGylkCDJyBg8nHvs4E4iQzR/bJhw+UASJrVT9DGc9ubg5vH3nCPinc4rYBYkx3r+Xl/+7iYFHCT
	MydG3RGb5bo9ELc8gOnh2iKkx/DQ/a+0xOTE2bDb6mWZ8TP9PbSpNxxuZwE5VirRW/u96C2TNmf
	n3I
X-Received: by 2002:a05:6102:2922:b0:7a3:4e75:d1f0 with SMTP id ada2fe7eead31-7a55d38b2b7mr6284952137.23.1790017341074;
        Mon, 21 Sep 2026 12:02:21 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7aad2e36ea7sm8429137.4.2026.09.21.12.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 12:02:20 -0700 (PDT)
Message-ID: <d90c0eec-728b-4607-b480-86b2534559c4@brivo.com>
Date: Mon, 21 Sep 2026 15:02:19 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org
Cc: Brian Masney <bmasney@redhat.com>, linux-kernel@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Potential deadlock in clk-pwm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found a potential deadlock in clk-pwm with lockdep. The problem occurs
when a multi-channel PWM calls a clock function (such as clk_get_rate) in
its apply callback. If one channel of the PWM is used for a clk-pwm, and
another channel is used for some other purpose, then the following deadlock
can occur:

CPU0                        CPU1
====================== =========================
pwm_get_state_hw(chip)
  guard(pwmchip)(chip)
		       clk_get_scaled_duty_cycle(clkb)
		        clk_prepare_lock()
		        clk_pwm_get_duty_cycle(clkb)
		         pwm_get_state_hw(chip)
		          guard(pwmchip)(chip)
  chip->get_state()
   clk_get_rate(clka)
    clk_prepare_lock()

The same scenario can play out with apply instead of get_state.  I don't
think this can really be fixed in clk-pwm. That driver doesn't have control
over whether it's called with prepare_lock held or not, and it has to call
into the PWM API in order to do anything.

One approach could be to convert the PWM drivers to avoid calling any
(sleeping) clock functions from apply. Fortunately, it seems like there are
not that many drivers used in-tree:

- pwm-imx27
- pwm-meson (by far the most prolific user)
- pwm-renesas-tpu
- pwm-tiecap (doesn't call any clock functions from apply/get_state)

and none of the in-tree users use any of the other channels AFAICT.

Unfortunately, converting these drivers to be atomic is non-trivial.
All of them enable/prepare their parent clock only when necessary to save
power. Converting them to prepare/disable in request/free could result
in increased power usage if the parent turns on in prepare instead of
enable. Additionally, pwm-meson also sets the clock rate for improved
accuracy, and this would have to be removed.

I suspect that removing these features to fix a bug that can't occur on
existing hardware would be well-received. On the other hand, pwms are
exposed to userspace, so I think a privileged user could deadlock the
system just by reading /sys/kernel/debug/pwm and
/sys/kernel/debug/clk/<name>/clk_duty_cycle repeatedly.

Does anyone have better ideas? I don't know if there's a way to catch this
bug at runtime without lockdep. Non-atomic drivers are still OK as long as
they don't take prepare_lock.

--Sean

======================================================
WARNING: possible circular locking dependency detected
6.18.52-yocto-standard-00169-gbc0cb063dbe7-dirty #1 Not tainted
------------------------------------------------------
kworker/u16:2/47 is trying to acquire lock:
ffff8000827d8968 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock (drivers/clk/clk.c:228)

but task is already holding lock:
c5ff000002bc77c8 (&chip->nonatomic_lock){+.+.}-{4:4}, at: pwm_apply_might_sleep (drivers/pwm/core.c:43 drivers/pwm/core.c:54 drivers/pwm/core.c:747)

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&chip->nonatomic_lock){+.+.}-{4:4}:
        __mutex_lock (kernel/locking/mutex.c:598 kernel/locking/mutex.c:760)
        mutex_lock_nested (kernel/locking/mutex.c:812 (discriminator 1))
        pwm_get_state_hw (drivers/pwm/core.c:43 drivers/pwm/core.c:54 drivers/pwm/core.c:812)
        clk_pwm_get_duty_cycle (drivers/clk/clk-pwm.c:71)
        clk_core_update_duty_cycle_nolock (drivers/clk/clk.c:3095)
        __clk_register (drivers/clk/clk.c:4032 drivers/clk/clk.c:4380)
        devm_clk_hw_register (drivers/clk/clk.c:4460 (discriminator 1) drivers/clk/clk.c:4684 (discriminator 1))
        clk_pwm_probe (drivers/clk/clk-pwm.c:152)
        platform_probe (drivers/base/platform.c:1377)
        really_probe (drivers/base/dd.c:640 drivers/base/dd.c:718)
        __driver_probe_device (drivers/base/dd.c:880)
        driver_probe_device (drivers/base/dd.c:910)
        __device_attach_driver (drivers/base/dd.c:1038)
        bus_for_each_drv (drivers/base/bus.c:462)
        __device_attach (drivers/base/dd.c:1110)
        device_initial_probe (drivers/base/dd.c:1159)
        bus_probe_device (drivers/base/bus.c:583)
        deferred_probe_work_func (drivers/base/dd.c:124)
        process_one_work (kernel/workqueue.c:3294)
        worker_thread (kernel/workqueue.c:3377 kernel/workqueue.c:3458)
        kthread (kernel/kthread.c:432)
        ret_from_fork (/usr/src/debug/linux-yocto/6.18.52+git/arch/arm64/kernel/entry.S:860)

-> #0 (prepare_lock){+.+.}-{4:4}:
        __lock_acquire (kernel/locking/lockdep.c:3167 kernel/locking/lockdep.c:3286 kernel/locking/lockdep.c:3910 kernel/locking/lockdep.c:5239)
        lock_acquire (kernel/locking/lockdep.c:5872 kernel/locking/lockdep.c:5829)
        __mutex_lock (kernel/locking/mutex.c:598 kernel/locking/mutex.c:760)
        mutex_lock_nested (kernel/locking/mutex.c:812 (discriminator 1))
        clk_prepare_lock (drivers/clk/clk.c:228)
        clk_set_rate (drivers/clk/clk.c:2592 drivers/clk/clk.c:2584)
        meson_pwm_enable.isra.0 (drivers/pwm/pwm-meson.c:235)
        meson_pwm_apply (drivers/pwm/pwm-meson.c:328)
        __pwm_apply (drivers/pwm/core.c:707)
        pwm_apply_might_sleep (drivers/pwm/core.c:761)
        pwm_adjust_config (drivers/pwm/core.c:897)
        pwm_regulator_probe (drivers/regulator/pwm-regulator.c:403)
        platform_probe (drivers/base/platform.c:1377)
        really_probe (drivers/base/dd.c:640 drivers/base/dd.c:718)
        __driver_probe_device (drivers/base/dd.c:880)
        driver_probe_device (drivers/base/dd.c:910)
        __device_attach_driver (drivers/base/dd.c:1038)
        bus_for_each_drv (drivers/base/bus.c:462)
        __device_attach_async_helper (drivers/base/dd.c:1067)
        async_run_entry_fn (kernel/async.c:129)
        process_one_work (kernel/workqueue.c:3294)
        worker_thread (kernel/workqueue.c:3377 kernel/workqueue.c:3458)
        kthread (kernel/kthread.c:432)
        ret_from_fork (/usr/src/debug/linux-yocto/6.18.52+git/arch/arm64/kernel/entry.S:860)

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&chip->nonatomic_lock);
                                lock(prepare_lock);
                                lock(&chip->nonatomic_lock);
   lock(prepare_lock);

  *** DEADLOCK ***

4 locks held by kworker/u16:2/47:
  #0: 81ff0000003dc948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3268)
  #1: 02ff800083a37d10 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3269 (discriminator 1))
  #2: afff000000a57140 (&dev->mutex){....}-{4:4}, at: __device_attach_async_helper (include/linux/device.h:1013 drivers/base/dd.c:1053)
  #3: c5ff000002bc77c8 (&chip->nonatomic_lock){+.+.}-{4:4}, at: pwm_apply_might_sleep (drivers/pwm/core.c:43 drivers/pwm/core.c:54 drivers/pwm/core.c:747)

stack backtrace:
CPU: 3 UID: 0 PID: 47 Comm: kworker/u16:2 Not tainted 6.18.52-yocto-standard-00169-gbc0cb063dbe7-dirty #1 PREEMPT
Hardware name: Blaze Edge 3.0 (DT)
Workqueue: async async_run_entry_fn
Call trace:
  show_stack (arch/arm64/kernel/stacktrace.c:499) (C)
  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
  dump_stack (lib/dump_stack.c:129)
  print_circular_bug (kernel/locking/lockdep.c:2045)
  check_noncircular (kernel/locking/lockdep.c:2177)
  __lock_acquire (kernel/locking/lockdep.c:3167 kernel/locking/lockdep.c:3286 kernel/locking/lockdep.c:3910 kernel/locking/lockdep.c:5239)
  lock_acquire (kernel/locking/lockdep.c:5872 kernel/locking/lockdep.c:5829)
  __mutex_lock (kernel/locking/mutex.c:598 kernel/locking/mutex.c:760)
  mutex_lock_nested (kernel/locking/mutex.c:812 (discriminator 1))
  clk_prepare_lock (drivers/clk/clk.c:228)
  clk_set_rate (drivers/clk/clk.c:2592 drivers/clk/clk.c:2584)
  meson_pwm_enable.isra.0 (drivers/pwm/pwm-meson.c:235)
  meson_pwm_apply (drivers/pwm/pwm-meson.c:328)
  __pwm_apply (drivers/pwm/core.c:707)
  pwm_apply_might_sleep (drivers/pwm/core.c:761)
  pwm_adjust_config (drivers/pwm/core.c:897)
  pwm_regulator_probe (drivers/regulator/pwm-regulator.c:403)
  platform_probe (drivers/base/platform.c:1377)
  really_probe (drivers/base/dd.c:640 drivers/base/dd.c:718)
  __driver_probe_device (drivers/base/dd.c:880)
  driver_probe_device (drivers/base/dd.c:910)
  __device_attach_driver (drivers/base/dd.c:1038)
  bus_for_each_drv (drivers/base/bus.c:462)
  __device_attach_async_helper (drivers/base/dd.c:1067)
  async_run_entry_fn (kernel/async.c:129)
  process_one_work (kernel/workqueue.c:3294)
  worker_thread (kernel/workqueue.c:3377 kernel/workqueue.c:3458)
  kthread (kernel/kthread.c:432)
  ret_from_fork (/usr/src/debug/linux-yocto/6.18.52+git/arch/arm64/kernel/entry.S:860)
