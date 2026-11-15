Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782519;
	b=KzKZ3FrBLAmW0I6QMDjqn1tiHPO1YHWNCTbIUkfZmBAjwUK434gqmmvATOeM984fvfxG
	 hCaOiG6M9BTGzblQXC6Ni1gGrd77XZlgehAKrxejjwK7nJB5IA9il7nmgFDiUlm3LehVH
	 Tztw8PEgCyRZ3M9AnIoMhvy5YQA2lCSdaxpUFJ6YprIlT6PK0upzNvmkMwjUG419kVEIw
	 Fd83QTftLwqSKWI99dZY3ZtJ/JQNBJAzT3WKc3rm9YfyqC9191hpZiHf+G3hNnCYDovK5
	 4MpCMqPVDslQS9Ewk+Mf2Ds1ifMaFMJE+eMAKjH5K3wsV2yaazOAD7SwKe4Krz53qTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782519;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pYcqPeDBuVWjWd3KEOJ+x52YkWqtkFvpjaJFAxcK0NM=;
	b=VYcZwGAPAJ4HzCgn+MjegVRo9dZW9P3t07dffTE2ylnZ4aRLb+4i8yLQXaK5s+aQv5Wf
	 UfU+lPMiOyRuW4jshm2fBEX85f/oHsnNq4XpcDsANJfpOfnQIwiZ9VplkAWqlee0gJYoY
	 bubfV8d944UyyMs5pqcrdQoXbzyOy4bR+rjuO3QLLd4bSn7lUJywMvIQcYs2aE6ZG94s7
	 ZWJEBRvBdJ6KREg4CRmhLXgKDkSynEP86xyPH8kzm1Kv13ZSDME0ILMRLQA99M6AUZN1A
	 ckntlWYS9JhN5pIPaIE1kpiw5GeI/O5ppmQEhcLEELXVL2B/xkZOc1El7b8b+76zdOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dsg.is;
	spf=pass smtp.mailfrom=dsg.is;
	dkim=pass header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b="Esx/HXis";
	arc=none smtp.remote-ip=79.135.106.26
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA9606A329
	for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 22:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68CA9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dsg.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsg.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=Esx/HXis
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dsg.is;
	s=protonmail2; t=1794782514; x=1795041714;
	bh=pYcqPeDBuVWjWd3KEOJ+x52YkWqtkFvpjaJFAxcK0NM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Esx/HXisvfyXSksv1WSOJeokhT4pTYapRTw1hzW//xrdk4KwkxJl0eEOlDIYuO1O5
	 gzVVjFUjacud+t49kPpcFkFRUtrFKBYgTl1BALKWF95JvTxLyjObiL8V4h70SYJeDg
	 M197jZM1fEE+1tDQFl06VvnedVMCrPVmMqL9RfRLv6BpfJ78wdtQ2SVHGa1ZdYV2cN
	 lZeX/vGBMfgdB8VD7qLlsWcmjV+yufm9j5NPRcyU93p/vYwQfSVQLrp2bR9oX+NdQ7
	 4Aceg//cKIiQERiepARr/+K0E2wvjZ9M9r7AXQQ+eaiaEXD5g19/y6uEqVwjhAFtlW
	 5udgCzYswohXA==
Date: Sun, 15 Nov 2026 22:41:46 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: =?utf-8?Q?Dav=C3=AD=C3=B0_Steinn_Geirsson?= <david@dsg.is>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (adt7475) Convert to hwmon_device_register_with_info()
Message-ID: <avo1IWkXBQ2fHgKx@dsg.is>
In-Reply-To: <62350363-b796-4637-a102-c668037bbbdd@roeck-us.net>
References: <20261114004110.328050-1-david@dsg.is> <20261114004110.328050-3-david@dsg.is> <d28f392e-82ea-44d6-83e5-9593b341a722@roeck-us.net> <avm-tbgWgTJNFTBj@dsg.is> <62350363-b796-4637-a102-c668037bbbdd@roeck-us.net>
Feedback-ID: 186389362:user:proton
X-Pm-Message-ID: f1e8768d8913b3bbffb9bd1119eb855bf7159a69
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 01:40:08PM -0800, Guenter Roeck wrote:
> On 11/15/26 06:16, Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
> > On Fri, Nov 13, 2026 at 10:07:53PM -0800, Guenter Roeck wrote:
> >> On 11/13/26 16:41, Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
> >>> Convert the driver from hwmon_device_register_with_groups() to
> >>> hwmon_device_register_with_info(). The standard voltage, temperature,
> >>> fan and PWM attributes move to hwmon_ops. The chip-specific attribute=
s
> >>> stay driver-defined and are passed as extra groups: the automatic fan
> >>> control points, temperature smoothing, PWM stall disable,
> >>> pwm_use_point2_pwm_at_crit and the VID attributes.
> >>>
> >>> The driver keeps data->lock, although the hwmon core serialises the
> >>> hwmon_ops callbacks. The attributes in the extra groups run outside t=
hat
> >>> serialisation, and they share the register cache and its periodic upd=
ate
> >>> with the hwmon_ops callbacks. They do not take hwmon_lock() instead, =
to
> >>> keep this conversion free of locking changes.
> >>>
> >>
> >> I disagree here. If you don't want to change the locks to use the hwmo=
n
> >> subsystem lock in this patch, add another patch to change the code to
> >> use it. The subsystem lock was not introduced to be ignored.
> >
> > Understood. I did notice one issue while planning that change. Patch 4
> > makes the chip a PWM provider, so its callbacks will also need the
> > lock. If the consumer is pwm-fan, then when userspace writes pwm-fan's
> > pwm attribute, the hwmon core holds pwm-fan's lock. pwm-fan then calls
> > into the PWM core, which calls into adt7475, which then needs to take
> > its own hwmon lock:
> >
> >    hwmon_attr_store()              takes pwm-fan's hwmon lock
> >      pwm_fan_write()
> >        pwm_apply_might_sleep()
> >          adt7475_pwm_write_waveform()
> >            hwmon_lock()            takes adt7475's hwmon lock
> >
> > As far as I can tell no driver does this today. adt7470 and
> > aspeed-g6-pwm-tach are the other PWM providers I found in drivers/hwmon=
,
> > and neither takes the subsystem lock in its PWM callbacks.
> >
>=20
> Ah, the usual "someone else does (or does not) do it".

Apologies if that's how it came off, that was not the intent. I
understand your earlier guidance that new drivers need to use the hwmon
subsystem lock for this kind of thing. The reason I mentioned those
other drivers was to try to explain why I believe this is a novel issue
other hwmon drivers have not hit before.=20

>=20
> > I haven't written any code for this yet, so this is based on my read
> > of the current code only. If correct, I think this would need a hwmon
> > core change to give each hwmon device its own lockdep class.
> >
>=20
> Hmm, if that is true (I'd like to see a lockddep warning), that will
> need to be fixed anyway. The situation above will be more common with the
> pwm subsystem maintainer pushing for that kind of architecture, so it wil=
l
> need to be fixed. Introducing / maintaining another layer of locks is not
> the solution.

I did prepare a minimal test case for this earlier today with qemu and
i2c-stub:
```
[    2.173321] =3D=3D=3D writing 100 to /sys/bus/platform/devices/pwm-fan.0=
/hwmon/hwmon1/pwm1
[    2.173516]=20
[    2.174872] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.175874] WARNING: possible circular locking dependency detected
[    2.176802] 7.4.0-rc2-00198-g073ebe4bdeea-dirty #1 Tainted: G           =
O      =20
[    2.178136] ------------------------------------------------------
[    2.179038] init/1 is trying to acquire lock:
[    2.179707] ffffa10c01f6e2a0 (&ctx->lock){+.+.}-{4:4}, at: pwm_fan_write=
+0x11e/0x288 [pwm_fan]
[    2.180942]=20
[    2.180942] but task is already holding lock:
[    2.181751] ffffa10c02411538 (&hwdev->lock){+.+.}-{4:4}, at: hwmon_attr_=
store+0x66/0x1c0
[    2.182999]=20
[    2.182999] which lock already depends on the new lock.
[    2.182999]=20
[    2.184193]=20
[    2.184193] the existing dependency chain (in reverse order) is:
[    2.185191]=20
[    2.185191] -> #2 (&hwdev->lock){+.+.}-{4:4}:
[    2.185989]        lock_acquire+0xcf/0x300
[    2.186532]        __mutex_lock+0xcf/0x1210
[    2.187149]        adt7475_pwm_write_waveform+0x29/0x90 [adt7475]
[    2.188046]        __pwm_write_waveform+0x1e/0xf0
[    2.188928]        __pwm_apply+0x49f/0x940
[    2.189554]        pwm_apply_might_sleep+0x67/0x100
[    2.190246]        __set_pwm+0x97/0x1e0 [pwm_fan]
[    2.191048]        pwm_fan_probe+0x157/0x790 [pwm_fan]
[    2.191822]        platform_probe+0x68/0xa0
[    2.192389]        really_probe+0xcd/0x2b0
[    2.193037]        __driver_probe_device+0x8e/0x180
[    2.193751]        driver_probe_device+0x1a/0x90
[    2.194359]        __device_attach_driver+0x7b/0xc0
[    2.195092]        bus_for_each_drv+0x9e/0x110
[    2.195741]        __device_attach+0xad/0x1c0
[    2.196324]        device_initial_probe+0x45/0x70
[    2.197013]        __bus_probe_device+0x3a/0xc0
[    2.197712]        device_add+0x6a9/0x8e0
[    2.198243]        platform_device_add+0x100/0x220
[    2.198995]        platform_device_register_full+0x191/0x210
[    2.199790]        0xffffffffc04091c7
[    2.200454]        do_one_initcall+0x99/0x310
[    2.201169]        do_init_module+0x65/0x260
[    2.201759]        init_module_from_file+0xbc/0x130
[    2.202425]        idempotent_init_module+0x1cb/0x330
[    2.203151]        __x64_sys_finit_module+0x74/0xe0
[    2.203851]        do_syscall_64+0x110/0x620
[    2.204447]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    2.205240]=20
[    2.205240] -> #1 (&chip->nonatomic_lock){+.+.}-{4:4}:
[    2.206208]        lock_acquire+0xcf/0x300
[    2.206794]        __mutex_lock+0xcf/0x1210
[    2.207382]        pwm_apply_might_sleep+0xad/0x100
[    2.208143]        __set_pwm+0x97/0x1e0 [pwm_fan]
[    2.208814]        pwm_fan_probe+0x157/0x790 [pwm_fan]
[    2.209530]        platform_probe+0x68/0xa0
[    2.210178]        really_probe+0xcd/0x2b0
[    2.210724]        __driver_probe_device+0x8e/0x180
[    2.211368]        driver_probe_device+0x1a/0x90
[    2.212210]        __device_attach_driver+0x7b/0xc0
[    2.212896]        bus_for_each_drv+0x9e/0x110
[    2.213508]        __device_attach+0xad/0x1c0
[    2.214150]        device_initial_probe+0x45/0x70
[    2.214844]        __bus_probe_device+0x3a/0xc0
[    2.215473]        device_add+0x6a9/0x8e0
[    2.216118]        platform_device_add+0x100/0x220
[    2.216758]        platform_device_register_full+0x191/0x210
[    2.217522]        0xffffffffc04091c7
[    2.218046]        do_one_initcall+0x99/0x310
[    2.218673]        do_init_module+0x65/0x260
[    2.219274]        init_module_from_file+0xbc/0x130
[    2.219988]        idempotent_init_module+0x1cb/0x330
[    2.220729]        __x64_sys_finit_module+0x74/0xe0
[    2.221414]        do_syscall_64+0x110/0x620
[    2.222097]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    2.222870]=20
[    2.222870] -> #0 (&ctx->lock){+.+.}-{4:4}:
[    2.223965]        check_prev_add+0xdb/0xee0
[    2.224558]        __lock_acquire+0xdb9/0x1cf0
[    2.225218]        lock_acquire+0xcf/0x300
[    2.225821]        __mutex_lock+0xcf/0x1210
[    2.226371]        pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.227204]        hwmon_attr_store+0x84/0x1c0
[    2.227870]        kernfs_fop_write_iter+0x185/0x240
[    2.228551]        vfs_write+0x285/0x6a0
[    2.229122]        ksys_write+0x7c/0x120
[    2.229717]        do_syscall_64+0x110/0x620
[    2.230284]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    2.231138]=20
[    2.231138] other info that might help us debug this:
[    2.231138]=20
[    2.232291] Chain exists of:
[    2.232291]   &ctx->lock --> &chip->nonatomic_lock --> &hwdev->lock
[    2.232291]=20
[    2.233773]  Possible unsafe locking scenario:
[    2.233773]=20
[    2.234839]        CPU0                    CPU1
[    2.235510]        ----                    ----
[    2.236157]   lock(&hwdev->lock);
[    2.236717]                                lock(&chip->nonatomic_lock);
[    2.237633]                                lock(&hwdev->lock);
[    2.238447]   lock(&ctx->lock);
[    2.238948]=20
[    2.238948]  *** DEADLOCK ***
[    2.238948]=20
[    2.239970] locks held by init/1: 4, on CPU#0:
[    2.240582]  #0: ffffa10c01f02450 (sb_writers#3){.+.+}-{0:0}, at: ksys_w=
rite+0x7c/0x120
[    2.241746]  #1: ffffa10c01f6fa80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs=
_fop_write_iter+0x13b/0x240
[    2.243002]  #2: ffffa10c0246ee78 (kn->active#2){.+.+}-{0:0}, at: kernfs=
_fop_write_iter+0x150/0x240
[    2.244300]  #3: ffffa10c02411538 (&hwdev->lock){+.+.}-{4:4}, at: hwmon_=
attr_store+0x66/0x1c0
[    2.245444]=20
[    2.245444] stack backtrace:
[    2.246031] CPU: 0 UID: 0 PID: 1 Comm: init Tainted: G           O      =
  7.4.0-rc2-00198-g073ebe4bdeea-dirty #1 PREEMPT(lazy)=20
[    2.247731] Tainted: [O]=3DOOT_MODULE
[    2.248194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    2.249765] Call Trace:
[    2.250101]  <TASK>
[    2.250393]  dump_stack_lvl+0x5d/0x90
[    2.250890]  print_circular_bug.cold+0x18f/0x1f1
[    2.251570]  check_noncircular+0x180/0x1b0
[    2.252206]  check_prev_add+0xdb/0xee0
[    2.252715]  __lock_acquire+0xdb9/0x1cf0
[    2.253231]  lock_acquire+0xcf/0x300
[    2.253792]  ? pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.254421]  ? hwmon_attr_store+0x66/0x1c0
[    2.254969]  ? lock_is_held_type+0xac/0x180
[    2.255584]  __mutex_lock+0xcf/0x1210
[    2.256081]  ? pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.256782]  ? pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.257410]  ? __mutex_lock+0x643/0x1210
[    2.257990]  ? pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.258697]  pwm_fan_write+0x11e/0x288 [pwm_fan]
[    2.259374]  ? __pfx_pwm_fan_write+0x10/0x10 [pwm_fan]
[    2.260091]  hwmon_attr_store+0x84/0x1c0
[    2.260656]  ? sysfs_file_kobj+0x6f/0x160
[    2.261194]  kernfs_fop_write_iter+0x185/0x240
[    2.261828]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[    2.262479]  vfs_write+0x285/0x6a0
[    2.262980]  ksys_write+0x7c/0x120
[    2.263474]  do_syscall_64+0x110/0x620
[    2.264055]  ? __irq_exit_rcu+0x33/0x140
[    2.264575]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    2.265281] RIP: 0033:0x4eee8f
[    2.265736] Code: 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 db c3 55 48 89 f8 =
4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 48 89 ca 48 89 e5 4c 8b 4d 10 0f 05 <5d=
> 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 45 31 db c3
[    2.268303] RSP: 002b:00007ffd0cec3750 EFLAGS: 00000212 ORIG_RAX: 000000=
0000000001
[    2.269350] RAX: ffffffffffffffda RBX: 00000000005322ac RCX: 00000000004=
eee8f
[    2.270389] RDX: 0000000000000004 RSI: 00007f7d8dd79780 RDI: 00000000000=
00001
[    2.271398] RBP: 00007ffd0cec3750 R08: 0000000000000000 R09: 00000000000=
00000
[    2.272390] R10: 0000000000000000 R11: 0000000000000212 R12: 00007f7d8dd=
79780
[    2.273364] R13: 0000000000000004 R14: 0000000000000000 R15: 00000000000=
00000
[    2.274331]  </TASK>
[    2.275512] =3D=3D=3D write returned 0;  debug_locks:   =20
```


>=20
> Anyway, you want to add the complexity of getting the pwm subsystem and
> the pwm-fan driver involved, even though this could as well be handled
> in the adt7475 driver, so you'll have to suffer the consequences.

I have no attachment to this implementation, in truth I just expected an
adt7475 driver registering cooling devices itself would be rejected. If
that approach is acceptable, I agree it would be simpler and side-step
this whole issue.

Thanks again for your time on this,
Dav=C3=AD=C3=B0


>=20
> Thanks,
> Guenter
>=20
> > I'm not quite confident enough in my understanding of the core to
> > commit to implementing such a change. But I'd appreciate your thoughts
> > on this.
> >
> >>
> >> Thanks,
> >> Guenter
> >>
> >
> > Thanks again,
> > Dav=C3=AD=C3=B0
>=20

