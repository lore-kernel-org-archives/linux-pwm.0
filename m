Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226525;
	b=TAUHIwaCDn4bXTgoNkor/iM6LhCGtBL9L7j7TwpMFrENhJ4bOOxdliAUW9fYzgVjl/SZ
	 kluV8ELGzYyAV6JyzPdtuNmQv0vXAk49noy4xVgQhgfu7E/fscCyTdhQhfwLUrxiVTOIC
	 v7dWx+jWyJUh8cd2FTenWdovw4bqSNT3J2n2nqmYj9S62Iolpg6uiok/K2+XxDnVN7cXD
	 Av9yDck9GyjIBGtr90vOeJsZMkM2oD5wy6eO/JB9Nl3nMkWzL4T62cYuIM2hrZ5coGsJj
	 VhbD2uICQMmtVNrTH6I6o7HYg7p95TkF/i++O0U8nRKngl6c3fQC9r13c9UAU1ZwOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fhltQ3C2YstOxFJltFlEf35j9R/LHxLY9qVdwx4Wd0Q=;
	b=dl+O+/GxVxWnJIsYCAUA1z958j2mEnqraDZkIpelHhlcdfuwtbftwKDXSQJoAvkuKUA9
	 6DNX8CFdJ/H37o50hZyK+S8+Ob2fuL9vEva/UMVUeQChSYe4XF4A9QJYspQG+Gdhohr7h
	 ba5/AWC/zGOvyiTIs3oIRkPuwHuKh3XTSyj9ZYgDwk16meBBZaGQqtDVgZVTnme3WDqae
	 Q6I6E0pUfW+h3GfH8HcfigFseoiDxA3MA5TZaoWfL/fSM246PPaoL/H6vRB72iEqAr9TE
	 UAxEXpRygb4NO1cgV32ANuKSZcIAC11pdUhgdfRA/TU6iDIzzZFpaC9PLG507w8CdBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	dkim=pass header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=C5ocgWHW;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741D606A31F
	for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 22:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6741D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=C5ocgWHW
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35b2c599f43so3180538eec.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1793226523; x=1793831323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhltQ3C2YstOxFJltFlEf35j9R/LHxLY9qVdwx4Wd0Q=;
        b=C5ocgWHW45HuZnRTVl5CVC5v09lnHr/KqliAheuoKPp081c5xJRObJuFcNdAS4eqsT
         7y4WRoJSL5QZbtWhhIvzEGc12FQnaxgdNrJT0xEmOOlQF+ALQycbn3ktsoSPNTEmVkQW
         WPmIRegZ+dTPQJgrs5qZYLi2tVTS/1WVnwA7QzrtvwqmINkIHPIFmAsVaXS70405Zpuv
         nIQ8ASGnbHyNA6ZhwyW08s49uiu9oRawTCGAQV7SqdjISDorCfZOYOi7gLtA2okGixWt
         dwPw4F1tS0xOOldL5mPHBsXgQddZM8IToS1jGIdqdW48M/D7umwnU337oRbPdNMh+KUi
         LBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226523; x=1793831323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhltQ3C2YstOxFJltFlEf35j9R/LHxLY9qVdwx4Wd0Q=;
        b=MKT7nkeSMskqmPEqhmTvJsVJfVNryYhmd23K+UKbmEOJg/PT+9VV7/lo/N80pgpCmX
         0n0+yWNCwqumLrcSjWACS2dDLvatDVVouhtYMzKCreEJSlCMD1hrzQyrQ4rgIlwrI56b
         SuAeVcfmUk9KWG2P6EeqdhOs3fMtlFSdRjAz284Z0sVZxc3gz6bivUeKVolxdrlC7D2a
         AtbDxZkSsFz1qlyQGM86VAGQ/w6YHgFT6NH+5B5S1xUYspZ6DqMdG+F5aKm9hk7otzPz
         qC+VH/qeY5137ekNLrPSz9Dh/rUWhH8DnT/SEMv/I+Xnnet4IrL2fO43lso5EZ0EZpwp
         zP/A==
X-Forwarded-Encrypted: i=1; AKwUvBxuFj1CS0yMlwB0xBRdM+RO6SjDBVzfLrdffYgbGyLejGGVr9d3N3sIox9UAkBjfFOJnK7BKVvrjHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyEwpG+s9UPEwCBzt8pQ908jkPONJJkWvfk9o/jnRZH0LQ8MLT
	NkAWu95qPsAHUv0v5gunXklg7ZqAR3B3HR96HglngdrtsTP3+9F2TFID86eSvqCKDFQ=
X-Gm-Gg: AYBFou1bJlvjGAg2LysIa3YB8N233AFbza3wcdhR9gguGovxTP4+myR0cxvZVl5PyRr
	NXKJYyJAXSsRh1RunCunphl+rwng1xQFL70+4JNmzNuegrTViOJLBsH6+6PU9GOxAWyFcD5GYel
	CCS5JQYj6O1Y9/ySa+i0tlnEYnQKRGbQtHHVNATzFBY7LeaMkfYYJLCu8lqXhnn9A59Fe+2SyBH
	YYjd8jhTr1deF2o3aGldkW+o1LzZ5d1Ppo4CT+mKHaEwBXaIX4aI33pT6IBBKdhlNWQ3so/K61J
	/37wH4+mxUTI+7lbUeeDDw5U3jlTervRYlo+ZZRjtT+voEP3YIyzjX21KkXDWVeR/SEzCrJ2uvR
	a4YLjiz8Dl951n6TcDSZ9Goc4OS8VTr0vM4U+mplWibXaZ4epZrWTdvs4KVqTICUIhgkwL/kEzb
	wQhJstwLBqqFx4/SK6XZmlNFvf+OVNSM3FEJ/I1uwqNVVnH/k40V5T+yS0IY1ktCIZ4haUlYKD5
	3lFWzSt3oHa5RrEWBOlS81nL8j2AVG/NlkRkTtg8XmC7spJao+6XLHeZPJEhQ56Afdkv+NVDY02
	eC/XhDkCmA5dBqgDacwGi2y/cp865yYX9UPa7Ru73O1ruXNAQKK0nQXxSyDkL4GjgV/QhP4ptMM
	l974hqyeSOtU=
X-Received: by 2002:a05:7301:924:b0:36a:43d:8ef7 with SMTP id 5a478bee46e88-36a20434747mr5414183eec.18.1793226523312;
        Wed, 28 Oct 2026 15:28:43 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a2390929asm12301773eec.12.2026.10.28.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:28:42 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: m.wilczynski@samsung.com,
	fustini@kernel.org,
	guoren@kernel.org,
	wefu@redhat.com,
	ukleinek@kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	elle@weathered-steel.dev,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 0/1] rust: pwm: track the owner module when registering `Chip`
Date: Wed, 28 Oct 2026 22:28:39 +0000
Message-Id: <cover.1793150685.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
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

Dear Linux kernel maintainers,

We are developing a tool called FerroLens to detect potential
unsound behavior in Rust code in the Linux kernel. The tool
internally uses an LLM to detect bugs.
We then perform manual analysis to verify these reports.
FerroLens reported the following bug in rust/kernel/pwm.rs:

`UnregisteredChip::register` calls the C function `__pwmchip_add` 
to register a PWM chip with the PWM core.
`__pwmchip_add` documents that its `owner` argument is supposed to 
be `THIS_MODULE`, but `UnregisteredChip::register` passes 
`core::ptr::null_mut()`. This is acceptable for built-in drivers.

However, for loadable drivers, registering the chip with a null owner
prevents the PWM core from taking a reference to the owner module when 
a PWM is requested or its character device is opened. 
This means that the owner module can be unloaded while references to the
chip remain. This can lead to use-after-free and
kernel panic.

Below is a PoC kernel module and associated python script that demonstrates
the issue.
The module can be unloaded while the PWM character-device file descriptor
is still open. When the file descriptor is closed, the final reference 
to the chip is dropped, which triggers the chip release callback from an 
already unloaded module. This leads to a kernel panic. 

    // SPDX-License-Identifier: GPL-2.0
    //! In-memory faux-device PWM provider for testing `UnregisteredChip::register`
    //! and the PWM character-device interface without physical PWM hardware.

    use kernel::{
        device,
        faux,
        prelude::*,
        pwm,
        sync::{new_mutex, Mutex},
    };

    const DEVICE_NAME: &CStr = c"pwmchip_add_poc";

    module! {
        type: PwmchipAddPoc,
        name: "pwmchip_add_poc",
        authors: ["Priya Govindasamy"],
        description: "In-memory PWM provider for pwmchip registration testing",
        license: "GPL",
        imports_ns: ["PWM"],
    }

    #[derive(Copy, Clone, Debug, Default)]
    struct PocWaveform {
        period_length_ns: u32,
        duty_length_ns: u32,
        duty_offset_ns: u32,
    }

    #[pin_data]
    struct PocOps {
        #[pin]
        waveform: Mutex<PocWaveform>,
    }

    impl pwm::PwmOps for PocOps {
        type WfHw = PocWaveform;

        fn round_waveform_tohw(
            _chip: &pwm::Chip<Self>,
            _pwm: &pwm::Device,
            wf: &pwm::Waveform,
        ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
            let period_length_ns = wf.period_length_ns.min(u64::from(u32::MAX)) as u32;
            let duty_length_ns = wf.duty_length_ns.min(u64::from(period_length_ns)) as u32;
            let duty_offset_ns = if period_length_ns == 0 {
                0
            } else {
                wf.duty_offset_ns
                    .min(u64::from(period_length_ns - 1)) as u32
            };

            Ok(pwm::RoundedWaveform {
                status: 0,
                hardware_waveform: PocWaveform {
                    period_length_ns,
                    duty_length_ns,
                    duty_offset_ns,
                },
            })
        }

        fn round_waveform_fromhw(
            _chip: &pwm::Chip<Self>,
            _pwm: &pwm::Device,
            wfhw: &Self::WfHw,
            wf: &mut pwm::Waveform,
        ) -> Result {
            *wf = pwm::Waveform {
                period_length_ns: u64::from(wfhw.period_length_ns),
                duty_length_ns: u64::from(wfhw.duty_length_ns),
                duty_offset_ns: u64::from(wfhw.duty_offset_ns),
            };

            Ok(())
        }

        fn read_waveform(
            chip: &pwm::Chip<Self>,
            _pwm: &pwm::Device,
            _parent_dev: &device::Device<device::Bound>,
        ) -> Result<Self::WfHw> {
            Ok(*chip.drvdata().waveform.lock())
        }

        fn write_waveform(
            chip: &pwm::Chip<Self>,
            _pwm: &pwm::Device,
            wfhw: &Self::WfHw,
            _parent_dev: &device::Device<device::Bound>,
        ) -> Result {
            *chip.drvdata().waveform.lock() = *wfhw;

            dev_info!(
                chip.device(),
                "stored waveform: period={} ns duty={} ns offset={} ns\n",
                wfhw.period_length_ns,
                wfhw.duty_length_ns,
                wfhw.duty_offset_ns
            );

            Ok(())
        }
    }

    struct PwmchipAddPoc {
        _fdev: faux::Registration,
    }

    impl kernel::Module for PwmchipAddPoc {
        fn init(_module: &'static ThisModule) -> Result<Self> {
            let fdev = faux::Registration::new(DEVICE_NAME, None)?;
            let dev = fdev.as_ref().as_ref();

            let chip = pwm::Chip::new(
                dev,
                1,
                try_pin_init!(PocOps {
                    waveform <- new_mutex!(PocWaveform::default()),
                }),
            )?;

            chip.register()?;

            dev_info!(dev, "one-channel in-memory PWM chip registered\n");
            dev_info!(
                dev,
                "current Rust register() passes NULL, not THIS_MODULE\n"
            );

            Ok(Self { _fdev: fdev })
        }
    }


python script - poc.py

  import os
  import sys
  import time

  # Check if effective user ID is root (0)
  if os.geteuid() != 0:
      print("Re-launching with sudo...")
      os.execvp("sudo", ["sudo", sys.executable] + sys.argv)

  fd = os.open("/dev/pwmchip0", os.O_RDWR)
  i = 0
  time.sleep(90)
  os.close(fd)


[24393.404056] Oops: int3: 0000 [#1] SMP KASAN PTI
[24393.404719] CPU: 8 UID: 0 PID: 11336 Comm: python3 Tainted: G           OE    N  7.3.0-rc5+ #80 PREEMPT(lazy)
[24393.405915] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [N]=TEST
[24393.406755] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[24393.407714] RIP: 0010:0xffffffffa05ba121
[24393.408166] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[24393.410391] RSP: 0018:ffff8882f033faf0 EFLAGS: 00000282
[24393.410988] RAX: 1ffff110241bc49d RBX: ffff88834e7a6800 RCX: 8000000000000001
[24393.411748] RDX: ffffffff84ccc660 RSI: ffffffff84b33dc0 RDI: ffff888120de2000
[24393.412490] RBP: ffff8882f033fb20 R08: ffff888120de203b R09: 1ffff110241bc407
[24393.413231] R10: dffffc0000000000 R11: ffffffffa05ba120 R12: dffffc0000000000
[24393.414162] R13: dffffc0000000000 R14: ffff888120de2000 R15: ffff888120de24e8
[24393.414952] FS:  00007f16044f2000(0000) GS:ffff888425dc4000(0000) knlGS:0000000000000000
[24393.415777] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24393.416376] CR2: 000022f4a14aa000 CR3: 00000003430b6001 CR4: 0000000000372ef0
[24393.417115] Call Trace:
[24393.417385]  <TASK>
[24393.417677]  ? device_release+0xc0/0x1c0
[24393.418290]  kobject_put+0x1e1/0x410
[24393.418739]  cdev_default_release+0x192/0x1b0
[24393.419250]  kobject_put+0x1e1/0x410
[24393.419649]  cdev_put+0x45/0x60
[24393.419996]  __fput+0x612/0x7a0
[24393.420343]  fput_close_sync+0x9a/0x130
[24393.420755]  __x64_sys_close+0x84/0xc0
[24393.421171]  x64_sys_call+0x815/0x2600
[24393.421644]  do_syscall_64+0x11c/0x3f0
[24393.422144]  ? debug_smp_processor_id+0x1b/0x30
[24393.422662]  ? rcu_is_watching+0x1a/0xc0
[24393.423108]  ? debug_smp_processor_id+0x1b/0x30
[24393.423594]  ? debug_smp_processor_id+0x1b/0x30
[24393.424086]  ? rcu_is_watching+0x1a/0xc0
[24393.424505]  ? trace_irq_disable+0x3c/0x130
[24393.424978]  ? do_syscall_64+0x6d/0x3f0
[24393.425390]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[24393.426080]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[24393.426879] RIP: 0033:0x7f16043150b7
[24393.427488] Code: ff e8 4d 15 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 e3 b8 f7 ff
[24393.429713] RSP: 002b:00007fff2611a4f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[24393.430658] RAX: ffffffffffffffda RBX: 000056304d48d870 RCX: 00007f16043150b7
[24393.431387] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[24393.432112] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[24393.432841] R10: 000056304d48d870 R11: 0000000000000246 R12: 000056304d48d870
[24393.433628] R13: 0000000000000000 R14: 00007f1604129db8 R15: 000056303ab55300
[24393.434532]  </TASK>
[24393.434783] Modules linked in: binfmt_misc intel_rapl_msr intel_rapl_common kvm_intel kvm rapl joydev i2c_piix4 e1000 i2c_smbus floppy qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 aesni_intel gf128mul input_leds psmouse mac_hid serio_raw pata_acpi [last unloaded: pwmchip_add_poc(OE)]
[24393.438940] ---[ end trace 0000000000000000 ]---
[24393.439415] RIP: 0010:0xffffffffa05ba121
[24393.439420] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[24393.439422] RSP: 0018:ffff8882f033faf0 EFLAGS: 00000282
[24393.439425] RAX: 1ffff110241bc49d RBX: ffff88834e7a6800 RCX: 8000000000000001
[24393.439427] RDX: ffffffff84ccc660 RSI: ffffffff84b33dc0 RDI: ffff888120de2000
[24393.439429] RBP: ffff8882f033fb20 R08: ffff888120de203b R09: 1ffff110241bc407
[24393.439431] R10: dffffc0000000000 R11: ffffffffa05ba120 R12: dffffc0000000000
[24393.439433] R13: dffffc0000000000 R14: ffff888120de2000 R15: ffff888120de24e8
[24393.439435] FS:  00007f16044f2000(0000) GS:ffff888425dc4000(0000) knlGS:0000000000000000
[24393.439438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24393.439439] CR2: 000022f4a14aa000 CR3: 00000003430b6001 CR4: 0000000000372ef0
[24393.439445] Kernel panic - not syncing: Fatal exception in interrupt
[24393.449336] Kernel Offset: disabled
[24393.449769] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Priya Bala Govindasamy (1):
  rust: pwm: track the owner module when registering `Chip`

 drivers/pwm/pwm_th1520.rs |  1 +
 rust/kernel/pwm.rs        | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1

