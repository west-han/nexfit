/*
테니스, 0, ISTJ 
수영, 1, ISFJ 
조깅, 2, INFJ 
클라이밍, 3, INTJ 
사이클링, 4, ISTP 
산책, 5, ISFP 
요가, 6, INFP 
헬스, 7, INTP 
격투기, 8, ESTP 
댄스, 9, ESFP 
하이킹, 10, ENFP 
서핑, 11, ENTP
탁구, 12, ESTJ
축구, 13, ESFJ
배구, 14, ENFJ
크로스핏, 15, ENTJ
*/

const qnaList = [
  {
    q: 'Q1. 우연히 보게 된 운동 영상, 나는 어떤 생각이 들까? ',
    
    a: [
      { answer: '오...(다음 영상 click)', type: ['0', '1', '4', '5', '8', '9', '12', '13'] },
      { answer: '저 사람을 커비처럼 삼켜서 아무런 노력없이 근육만 갖고 싶다!', type: ['2', '3', '6', '7', '10', '11', '14', '15'] },
    ]
  },
  {
    q: 'Q2. 이제는 정말 운동뿐이야! 누구와 함께 할까? ',
    a: [
      { answer: '친구한테 연락해서 같이 하자고 해야겠다.', type: ['8', '9', '10', '11', '12', '13', '14', '15'] },
      { answer: '운동은 혼자서 하는거지!', type: ['0', '1', '2', '3', '4', '5', '6', '7'] },
    ]
  },
  {
    q: 'Q3. 처음 운동을 시작하려는 당신, 뭐부터 하면 좋을까? ',
    a: [
      { answer: '엑셀에 헬스장의 위치와 가격, 운동 계획 등을 PLAN A~Z까지 작성한다.', type: ['0', '1', '2', '3', '12', '13', '14', '15'] },
      { answer: '내일부터 운동이다!', type: ['4', '5', '6', '7', '8', '9', '10', '11'] },
    ]
  },
  {
    q: 'Q4. 운동할 때 제대로 배우고 싶어 수업을 선택한 당신, 개인 수업 vs 단체 수업 ',
    a: [
      { answer: '아직 개인수업은 부담스러워. 단체 수업으로 시작해보겠어! ', type: ['8', '9', '10', '11', '12', '13', '14', '15'] },
      { answer: '기초부터 탄탄히 다지려면 개인수업이지!', type: ['0', '1', '2', '3', '4', '5', '6', '7' ] },
    ]
  },
  {
    q: 'Q5. "나 운동하다가 다쳤어ㅠㅠ", 당신의 대답은? ',
    a: [
      { answer: '괜찮아? 아팠겠다ㅠㅠ ', type: ['1', '2', '5', '6', '9', '10', '13', '14' ] },
      { answer: '병원은 가봤어? 어쩌다가 다쳤는데? ', type: ['0', '3', '4', '7', '8', '11', '12', '15' ]},
    ]
  },

  {
    q: 'Q6. 친구와 잡은 운동약속, 갑자기 취소 되었다...? ',
    a: [
      { answer: '개꿀! ', type: ['0', '1', '2', '3', '4', '5', '6', '7' ] },
      { answer: '아쉽지만 나 혼자서라도 운동하러 가야겠다! ', type: ['8', '9', '10', '11', '12', '13', '14', '15' ] },
    ]
  },
  {
    q: 'Q7. 운동을 너무 열심히 한 나머지 근육통이 생겼다. ',
    a: [
      { answer: '근육통이 생길 정도로 열심히 한 나 자신...멋져!', type: ['1', '2', '5', '6', '9', '10', '13', '14'] },
      { answer: '근육통은 어떻게 풀어주지?(검색)', type: ['0', '3', '4', '7', '8', '11', '12', '15' ] },
    ]
  },
  {
    q: 'Q8. 오늘은 운동하는 날! 그런데 친구가 맛집에 가자고 전화한다면? ',
    a: [
      { answer: '"하루 정도는 뭐ㅎㅎ" 당장 만나자고 전화한다.', type: ['4', '5', '6', '7', '8', '9', '10', '11'] },
      { answer: '운동루틴이 흐트러지면 다음 운동에 영향이 갈 수 있으니 다음에 만나자고 한다.', type: ['0', '1', '2', '3', '12', '13', '14', '15' ] },
    ]
  },
  {
    q: 'Q9. 아마추어 운동 대회에 나가기로 한 당신, 무슨 생각을 할까? ',
    a: [
      { answer: '상을 받고 인터뷰 하는 상상 + 유퀴즈 출연', type: ['2', '3', '6', '7', '10', '11', '14', '15' ] },
      { answer: '아마추어 운동 대회에서 우승하려면 연습일을 더 늘려야 겠어.', type: ['0', '1', '4', '5', '8', '9', '12', '13'] },
    ]
  },
  {
    q: 'Q10. 헬스장에 막 도착한 당신, 그런데 문이 닫혀 있다? ',
    a: [
      { answer: '그럼 오늘 운동은 조깅이다~', type: ['4', '5', '6', '7', '8', '9', '10', '11'] },
      { answer: '이미 인스타그램 공지로 확인해서 오늘은 다른 헬스장으로 갔다. ', type: ['0', '1', '2', '3', '12', '13', '14', '15' ] },
    ]
  },
  {
    q: 'Q11. 운동을 시작하고 3개월 뒤, 내 모습은? ',
    a: [
      { answer: '근육맨이 되어 있을 생각에 벌써 설렌다.', type: ['2', '3', '6', '7', '10', '11', '14', '15' ] },
      { answer: '운동 방법과 루틴을 점검하고 바꿔야 겠다.', type: ['0', '1', '4', '5', '8', '9', '12', '13'] },
    ]
  },
  {
    q: 'Q12. 운동 약속에 늦은 당신! 친구에게 할 말은? ',
    a: [
      { answer: '늦어서 미안해:( 오는 길에 코끼리가 길을 막고 있어서 늦었어!', type: ['1', '2', '5', '6', '9', '10', '13', '14' ] },
      { answer: '진짜 미안해:( 다음부터 늦으면 내가 홍대 한복판에서 삼겹살 구울게! ', type: ['0', '3', '4', '7', '8', '11', '12', '15'] },
    ]
  }
]

const infoList = [
  {
    name: '테니스 챔피언, 전략의 대가\n <테니스>',
    desc: '체계적이고 계획적인 성향을 가진 당신은 테니스 코트에서 모든 샷에 철저한 전략을 세우며 완벽을 추구하는 스타일이에요. 규칙에 충실하고 목표 지향적인 당신은 테니스의 기술적인 측면에서 최고의 실력을 발휘합니다. 정확한 타격과 뛰어난 집중력으로 상대를 압도하며, 꾸준한 연습과 노력으로 꾸준한 성장을 이루는 당신의 모습이 눈부셔요. 하지만 너무 완벽을 추구하다가 즐기는 마음을 잃지 않도록 유의하세요! '
  },
  {
    name: '물속의 평화, 헌신적인 힐러\n <수영>',
    desc: '따뜻하고 배려심 많은 당신은 수영장에서 물의 부드러운 흐름과 함께 고요한 평화를 찾습니다. 수영의 리듬 속에서 안정감을 느끼며, 자신과의 조화로운 시간을 보내는 것을 좋아해요. 수영장에서의 훈련과 연습은 당신의 인내력과 신뢰감을 높이며, 자신을 돌보는 시간을 소중히 여깁니다. 조용히 자신의 한계를 넘어서면서도 주변 사람들에게 힘이 되는 존재가 되는 당신의 모습이 감동적이에요. '
  },
  {
    name: '사색의 길, 내면의 여정\n <조깅>',
    desc: '깊은 생각과 내면의 성찰을 중시하는 당신은 조깅을 통해 마음의 평화를 찾고, 새로운 영감을 얻습니다. 고요한 아침이나 황혼의 시간에 조깅을 하며 생각을 정리하고 자신의 길을 찾는 것을 즐깁니다. 한 걸음 한 걸음이 당신에게는 자기 발견의 여정이며, 그 과정에서 삶의 의미를 재해석하게 됩니다. 꾸준한 조깅을 통해 내적 성장을 이루고, 삶에 새로운 활력을 불어넣는 당신은 진정한 정신적 탐험가에요.'
  },
  {
    name: '전략적 도전, 정상의 정복자\n <클라이밍>',
    desc: '목표 지향적이고 분석적인 당신은 클라이밍에서 모든 장애물을 계획적으로 극복하며 정상에 오르는 쾌감을 느낍니다. 복잡한 문제를 해결하고 도전적인 목표를 달성하는 데 뛰어난 능력을 발휘하는 당신은 클라이밍의 매 순간이 지적인 도전이 됩니다. 각 단계마다 세심한 계획을 세우고, 체계적으로 실행하며, 정상에 도달할 때의 성취감을 즐깁니다. 자신의 한계를 넘어서며 새로운 높이에 도전하는 당신의 모습은 영감을 줍니다.'
  },
  {
    name: '자유로운 속도, 모험의 라이더\n <사이클링>',
    desc: '독립적이고 탐구적인 당신은 사이클링에서 바람을 가르며 진정한 자유와 모험을 만끽합니다. 순간의 감각을 즐기며 자신만의 속도로 세상을 탐험하는 것을 좋아하는 당신은 사이클링의 빠른 스피드와 역동적인 움직임에서 짜릿한 쾌감을 느낍니다. 언제나 새로운 길을 탐험하고, 다양한 도전을 즐기며, 순간순간을 최대한으로 활용하는 당신은 진정한 자유로운 영혼이에요.'
  },
  {
    name: '자연 속의 예술가, 감성적인 산책자\n <산책>',
    desc: '감성적이고 예술적인 당신은 산책을 통해 자연과 하나 되는 순간을 즐깁니다. 아름다운 풍경과 신선한 공기를 마시며, 마음의 평화를 찾는 것을 좋아해요. 자연 속에서의 산책은 당신에게 힐링과 영감을 주며, 매 걸음마다 새로운 발견을 하게 됩니다. 조용한 길을 걸으며 자신을 표현하고, 현재의 순간을 온전히 느끼는 당신은 자연과 조화를 이루는 진정한 예술가입니다.'
  },
  {
    name: '내면의 조화, 영혼의 탐구자\n <요가>',
    desc: '깊은 내면의 성찰과 조화를 추구하는 당신은 요가를 통해 영혼과 몸의 균형을 찾습니다. 요가 매트 위에서 마음의 평화를 느끼며, 깊은 호흡과 함께 자기 이해를 높이는 시간을 소중히 여깁니다. 다양한 포즈와 명상을 통해 내면의 평화를 경험하고, 삶의 스트레스를 해소하며, 자신을 돌보는 시간이 중요해요. 요가를 통해 몸과 마음의 조화를 이루는 당신은 진정한 내면의 탐구자입니다.'
  },
  {
    name: '지적인 훈련, 체력의 연구자\n <헬스>',
    desc: '분석적이고 탐구적인 당신은 헬스장에서 자신의 신체와 능력을 체계적으로 연구하고 발전시킵니다. 다양한 운동 기구를 활용해 새로운 운동 방식을 탐구하고, 체력과 근력을 향상시키는 데 집중하는 것을 좋아해요. 운동 계획을 세우고, 지속적으로 자신의 기록을 갱신하며, 신체적인 발전을 이루는 과정에서 큰 만족감을 느낍니다. 지적인 접근으로 신체를 강화하는 당신은 진정한 체력의 연구자입니다.'
  },
  {
    name: '즉각적 반응, 전장의 승부사\n <격투기>',
    desc: '순간의 반응과 빠른 판단력을 요구하는 격투기는 도전적이고 활기찬 당신에게 완벽한 운동입니다. 격투기의 빠른 속도와 강렬한 액션 속에서 자신을 한계까지 밀어붙이며, 매 순간을 즐깁니다. 강한 경쟁심과 승부욕을 발휘하며, 상대와의 대결에서 승리를 쟁취하는 과정이 당신에게 큰 만족감을 줍니다. 빠르게 변하는 상황에 적응하고, 강력한 공격과 방어로 승리를 이루는 당신은 진정한 전장의 승부사입니다.'
  },
  {
    name: '리듬의 주인공, 생동감 넘치는 댄서\n <댄스>',
    desc: '생동감 넘치는 에너지와 창의적인 성향을 가진 당신은 댄스에서 진정한 자신을 표현합니다. 음악과 함께 자유롭게 몸을 움직이며, 주변 사람들에게 즐거움과 활기를 불어넣는 것을 좋아해요. 다양한 춤 동작과 리듬에 몸을 맡기며, 무대 위에서 빛나는 주인공이 되는 당신은 진정한 퍼포머입니다. 매 순간을 최대한으로 즐기며, 자신의 열정과 에너지를 발산하는 당신의 모습은 보는 이들에게 큰 감동을 줍니다.'
  },
  {
    name: '모험의 탐험가, 자연 속의 자유\n <하이킹>',
    desc: '활기차고 모험을 사랑하는 당신은 하이킹을 통해 새로운 길과 풍경을 탐험하는 것을 즐깁니다. 자연 속에서의 자유와 신선한 공기를 만끽하며, 매 순간 새로운 발견과 경험을 소중히 여깁니다. 산과 들을 넘나들며 자신의 호기심을 충족시키고, 주변의 아름다움을 만끽하는 당신은 진정한 모험의 탐험가입니다. 하이킹을 통해 자신을 더욱 깊이 이해하고, 삶의 활력을 되찾는 시간을 가지세요.'
  },
  {
    name: '파도의 도전자, 역동적인 서퍼\n <서핑>',
    desc: '도전적이고 창의적인 당신은 서핑에서 파도를 타며 진정한 스릴과 자유를 느낍니다. 끊임없이 변화하는 파도 속에서 균형을 잡고, 순간의 결정으로 새로운 움직임을 시도하는 것을 즐깁니다. 파도를 정복하며 자신의 한계를 넘어서고, 매 순간이 새로운 기회로 다가오는 서핑은 당신에게 완벽한 운동입니다. 바다와 하나 되어 진정한 자유를 느끼며, 자신의 용기와 창의성을 발휘하세요. '
  },
  {
    name: '정확한 전략, 경기의 승부사\n <탁구>',
    desc: '조직적이고 목표 지향적인 당신은 탁구에서 빠르고 정확한 전략으로 상대를 압도합니다. 빠른 속도와 정확한 타격으로 게임의 흐름을 주도하며, 승리를 위해 체계적으로 계획을 세우고 실행하는 것을 즐깁니다. 상대방의 움직임을 예측하고, 순간의 판단으로 승부를 결정짓는 당신은 진정한 경기의 승부사입니다. 매 경기마다 자신을 발전시키고, 최고의 실력을 발휘하는 당신의 모습이 멋집니다. '
  },
  {
    name: '팀의 주역, 협동의 리더\n <축구>',
    desc: '사회적이고 협동적인 당신은 축구장에서 팀의 중심이 되어 진정한 공동체 정신을 발휘합니다. 함께 달리고 패스를 주고받으며, 팀의 승리를 위해 헌신하는 것을 즐기며, 다른 사람들과의 협력에서 큰 만족감을 느낍니다. 뛰어난 커뮤니케이션 능력으로 팀을 이끌고, 모든 플레이에서 팀의 성공을 위해 최선을 다하는 당신은 진정한 팀의 주역입니다. 축구를 통해 사람들과 깊은 유대감을 형성하고, 함께 이루는 승리의 기쁨을 만끽하세요. '
  },
  {
    name: '조화의 마에스트로, 팀워크의 중재자\n <배구>',
    desc: '외향적이고 타인을 돕는 것을 즐기는 당신은 배구에서 팀의 조화를 이끌어내며 진정한 리더십을 발휘합니다. 매 스파이크와 서브에 열정을 쏟으며, 팀원들의 성장을 돕고, 함께 목표를 이루기 위해 노력합니다. 뛰어난 사람 이해 능력으로 팀의 조화를 유지하며, 모든 플레이에서 최선을 다해 팀의 성공에 기여하는 당신은 진정한 팀워크의 중재자입니다. 배구를 통해 사람들과 깊은 연결을 형성하고, 함께 이루는 성취를 즐기세요. '
  },
  {
    name: '최고의 도전, 한계의 리더\n <크로스핏>',
    desc: '리더십과 강한 목표 지향성을 가진 당신은 크로스핏에서 자신의 한계를 넘어서며 최고의 성취감을 느낍니다. 체력과 지구력을 시험하며, 강렬한 훈련을 통해 자신을 지속적으로 발전시키는 것을 좋아해요. 각기 다른 운동을 조합해 최대한의 효과를 끌어내며, 목표 달성을 위해 끊임없이 노력하는 당신은 진정한 한계의 리더입니다. 크로스핏을 통해 자신의 잠재력을 극대화하고, 새로운 도전을 받아들이는 과정에서 큰 만족감을 얻으세요. '
  },
]
