From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 0/5] pwm: Fixes and support for Tegra186
Date: Wed, 22 Jun 2016 17:17:18 +0530
Message-ID: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

Have fixes for 100% duty cycle, avoid computation loss for duty
period calculation and add support the Tegra186.

Hyong Bin Kim (1):
  pwm: tegra: fix overflow when calculating duty cycle

Laxman Dewangan (2):
  pwm: tegra: Add DT node compatible for Tegra186
  pwm: tegra: Add support for Tegra186

Rohith Seelaboyina (1):
  pwm: tegra: Add support for reset control

Victor(Weiguo) Pan (1):
  pwm: tegra: Allow 100% duty cycle

 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 +++--
 drivers/pwm/pwm-tegra.c                            | 46 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.1.4
